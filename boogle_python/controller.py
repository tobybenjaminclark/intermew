import json
import threading
from boogle_python.cv_client import GMS2Client
from boogle_python.streams.test_stream import TestStream
from boogle_python.streams.camera_stream import CameraStream
from boogle_python.streams.emotion_stream import EmotionStream
from boogle_python.streams.speech_recognition_stream import SpeechRecognitionStream
from boogle_python.misc.prompt_generator import PromptGenerator

from queue import Queue
import cv2
import pandas as pd

class Controller:
    def __init__(self) -> None:
        self.client_replies_queue = Queue()
        self.stream_instances = {}  # Store stream instances and their queues
        self.running = True
        self.datafiles_location = "game/datafiles/"
        
        self.initialize_streams()
        self.create_client()
        

        self.prompt_generator_instance = PromptGenerator(self.client_queue, self)
        
    def create_client(self) -> None:
        """Creates a thread which initializes the client."""
        self.client = GMS2Client(self)
        self.client_queue = self.client.client_queue
        self.client.start_thread()

    def initialize_streams(self) -> None:
        """Initializes the test and camera streams."""
        self.create_stream('camera_stream', CameraStream)
        self.create_stream('emotion_stream', EmotionStream)
        self.create_stream('speech_recognition_stream', SpeechRecognitionStream)

    def create_stream(self, name: str, stream_class) -> None:
        """Generic method to create a stream instance."""
        stream_instance = stream_class()
        self.stream_instances[name] = {
            'instance': stream_instance,
            'queue': stream_instance.send_queue
        }

    def mainloop(self) -> None:
        """Program Main Loop. Retrieves gesture detections and sends them to GameMaker server."""
        cap = cv2.VideoCapture(0)  # Change to your capture source

        while self.running:
            ret, frame = cap.read()
            self.update_threads(frame)
            self.update_client()
        print("stopped running")

    def update_threads(self, frame):
        """Updates each stream's frame if it exists."""
        for stream_info in self.stream_instances.values():
            stream_instance = stream_info['instance']
            if stream_instance.exists:
                stream_instance.frame = frame
                stream_instance.new_data = True

    def update_client(self) -> None:
        """Attempt to update the client. Handle keyboard interrupt exceptions."""
        self.try_transmit_to_client()
    
    def terminate_program(self) -> None:
        """Safely end all threads and terminate the main process."""
        print("CTRL+C has been pressed. Ending threads.")
        self.stop_all_streams()
        self.client.stop_thread()
        self.running = False

    def stop_all_streams(self):
        for stream_info in self.stream_instances.values():
            if stream_info['instance'].exists:
                stream_info['instance'].stop_thread()  # Stop the thread using the instance


    def try_transmit_to_client(self) -> bool:
        """Handles sending and receiving messages with the client."""
        if not self.client.connected:
            return False

        # SEND
        for name, stream_info in self.stream_instances.items():
            queue = stream_info['queue']
            if not queue.empty():
                message = queue.get()
                self.client_queue.put(message)

        # RECEIVE
        if not self.client_replies_queue.empty():
            replies_dict = self.client_replies_queue.get()
            print(f"replies: {repr(replies_dict)}")
            self.handle_client_replies(replies_dict)
            return True
        return False

    def handle_client_replies(self, replies_dict) -> None:
        """Handles replies from the client and manages thread states."""

        if "action" in replies_dict:
            match replies_dict["action"]:
                case "start_interview":
                    file_name = replies_dict["job_chosen"]
                    file_location = self.datafiles_location + file_name
                    thread = threading.Thread(target = self.prompt_generator_instance.start_interview, args = (file_location,))
                    thread.start()
                case "input":
                    user_reply = self.stream_instances["speech_recognition_stream"]["instance"].buffer
                    print(f"\n\nreply: {user_reply}")
                    self.stream_instances["speech_recognition_stream"]["instance"].buffer = ""
                    thread = threading.Thread(target = self.prompt_generator_instance.generate_prompt, args = (user_reply,))
                    thread.start()



        if "from" in replies_dict:
            stream_name = replies_dict["from"]  # Extract stream name
            if stream_name in self.stream_instances:
                stream_instance = self.stream_instances[stream_name]['instance']
                match replies_dict["status"]:
                    case "create":
                        if not stream_instance.exists:
                            print("creating thread")
                            stream_instance.start_thread()  # Call start_thread on the instance
                    case "destroy":
                        if stream_instance.exists:
                            stream_instance.stop_thread()  # Call stop_thread on the instance



