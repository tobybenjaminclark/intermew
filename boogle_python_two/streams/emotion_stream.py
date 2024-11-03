
from queue import Queue
import threading
import json
import time
import cv2
from deepface import DeepFace
import csv
import pandas as pd

import numpy as np

class EmotionStream():
    stop_event: threading.Event      # Event to signal the termination of the thread.
    send_queue: Queue             # Queue to transfer data from the subthread to the main thread.

    def __init__(self):
        """
        Initialise the stop event and queue.
        """

        self.frame = None
        self.last_sent = time.time()


        # Create an event to signal the subthreads to safely stop execution.
        self.stop_event: threading.Event = threading.Event()
        self.send_queue = Queue()
        self.new_data = False

        # Load face cascade classifier
        self.face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

        self.file_path = "./emotions.csv"
        self.initialize_csv()

        
        self.exists = False


    # Initialize the CSV file with header
    def initialize_csv(self):
        header = ["angry", "disgust", "fear", "happy", "sad", "surprise", "neutral", "face_position_x", "face_position_y", "center_closeness"]
        with open(self.file_path, mode="w", newline="") as file:
            writer = csv.writer(file)
            writer.writerow(header)  # Write the header only once at the start



    def start_thread(self) -> None:
        self.create_thread()
        
    def create_thread(self) -> threading.Thread:
        
        self.exists = True
        # ',' used in thread args to convert the single argument to a tuple.
        self.thread: threading.Thread
        self.thread = threading.Thread(
            target=self.begin_retrieval, args=(self.stop_event,)
        )
        self.thread.start()


    def stop_thread(self) -> None:
        self.stop_event.set()
        self.thread.join()


    def send_data(self) -> None:

        if self.exists is False: return
        if self.new_data is False: return

        # Convert frame to grayscale
        gray_frame = cv2.cvtColor(self.frame, cv2.COLOR_BGR2GRAY)

        # Convert grayscale frame to RGB format
        rgb_frame = cv2.cvtColor(gray_frame, cv2.COLOR_GRAY2RGB)

        # Assuming you have screen dimensions
        screen_width = rgb_frame.shape[1]
        screen_height = rgb_frame.shape[0]

        # Center of the screen
        screen_center_x = screen_width / 2
        screen_center_y = screen_height / 2

        
        # Detect faces in the frame
        faces = self.face_cascade.detectMultiScale(gray_frame, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

        for (x, y, w, h) in faces:
            # Extract the face ROI (Region of Interest)
            face_roi = rgb_frame[y:y + h, x:x + w]
            
            # Perform emotion analysis on the face ROI
            result = DeepFace.analyze(face_roi, actions=['emotion'], enforce_detection=False)

            anger = np.round(result[0]["emotion"]["angry"] / 100, 3)
            disgust = np.round(result[0]["emotion"]["disgust"] / 100, 3)
            fear = np.round(result[0]["emotion"]["fear"] / 100, 3)
            happiness = np.round(result[0]["emotion"]["happy"] / 100, 3)
            sadness = np.round(result[0]["emotion"]["sad"] / 100, 3)
            surprise = np.round(result[0]["emotion"]["surprise"] / 100, 3)
            neutral = np.round(result[0]["emotion"]["neutral"] / 100, 3)



            face_position_x = x + w/2
            face_position_y = y + h/2

            # Calculate the Euclidean distance from the face center to the screen center
            distance_to_center = np.sqrt((face_position_x - screen_center_x) ** 2 + (face_position_y - screen_center_y) ** 2)

            # Maximum possible distance (from screen center to a corner of the screen)
            max_distance = np.sqrt(screen_center_x ** 2 + screen_center_y ** 2)

            # Calculate the closeness to the center as a percentage
            center_closeness = (1 - distance_to_center / max_distance)

            # Ensure percentage is within 0 to 100
            center_closeness = max(0, min(center_closeness, 1))

            dominant_emotion = result[0]["dominant_emotion"]

            with open(self.file_path, mode="a", newline="") as file:
                writer = csv.writer(file)
                writer.writerow([anger, disgust, fear, happiness, sadness, surprise, neutral, face_position_x, face_position_y, center_closeness])

            current_time = time.time()
            if current_time - self.last_sent > 1:
                self.last_sent = current_time
                data = {"from": "emotion_stream",
                        "dominant_emotion": dominant_emotion}
                self.send_queue.put(data)

            # Draw rectangle around face and label with predicted emotion
            #cv2.rectangle(self.frame, (x, y), (x + w, y + h), (0, 0, 255), 2)
            #cv2.putText(self.frame, dominant_emotion, (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (0, 0, 255), 2)
        #cv2.imshow("", self.frame)
        #cv2.waitKey(1)

        self.new_data = False

    def begin_retrieval(self, stop_event) -> None:

        while not stop_event.is_set():
            self.send_data()
            time.sleep(0.1)

    def get_interview_data(self, feedback: str, num_portions=50):
        # Read the CSV file
        data = pd.read_csv(self.file_path)

        # Calculate the number of rows per portion
        portion_size = len(data) // num_portions
        averages = {}

        for i in range(num_portions):
            start_index = i * portion_size
            end_index = (i + 1) * portion_size if i < num_portions - 1 else len(data)

            # Calculate the average for each column in the current portion
            portion_data = data.iloc[start_index:end_index]
            avg_values = portion_data.mean().to_dict()

            # Store the averages in the results dictionary
            averages[f'portion_{i + 1}'] = avg_values

        # Add the feedback to the averages dictionary
        averages['feedback'] = feedback  # Include feedback as part of the averages

        print(averages)

        # Prepare the data dictionary for sending to the queue
        data = {
            "from": "emotion_stream",
            "aggregate_data": averages
        }

        # Send the updated data to the queue
        self.send_queue.put(data)


if __name__ == "__main__":
    cap = cv2.VideoCapture(0)  # Change to your capture source
    emotion = EmotionStream()
    thr = emotion.create_thread()
    


    while 1:
        ret, frame = cap.read()
        emotion.frame = frame
        emotion.new_data = True