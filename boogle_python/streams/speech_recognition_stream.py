import threading
import json
import time
from queue import Queue
import speech_recognition as sr


class SpeechRecognitionStream():
    stop_event: threading.Event      # Event to signal the termination of the thread.
    send_queue: Queue             # Queue to transfer data from the subthread to the main thread.

    def __init__(self):
        """
        Initialize the stop event and queue.
        """

        # Create an event to signal the subthreads to safely stop execution.
        self.stop_event: threading.Event = threading.Event()
        self.send_queue = Queue()

        self.recognizer = sr.Recognizer()
        self.exists = False

    def start_thread(self) -> None:
        self.create_thread()

    def create_thread(self) -> threading.Thread:
        self.buffer = ""
        self.exists = True
        self.stop_event: threading.Event = threading.Event()
        self.thread = threading.Thread(
            target=self.begin_retrieval, args=(self.stop_event,)
        )
        self.thread.start()

    def stop_thread(self) -> None:
        self.exists = False
        self.stop_event.set()
        self.thread.join()

    def send_data(self) -> None:

        print(f"speech recognition sending data")
        if not self.exists:
            return

        with sr.Microphone() as source:
            # Apply noise reduction
            self.recognizer.adjust_for_ambient_noise(source)
            try:
                # Capture and process the audio
                audio = self.recognizer.listen(source, timeout=0)
                text = self.recognizer.recognize_google(audio)
                self.process_text(text)
            except sr.UnknownValueError:
                print("Speech not understood")
            except sr.RequestError:
                print("Speech recognition service unavailable")

    def process_text(self, text: str) -> None:
        self.buffer += text
        data = json.dumps({"from": "speech_recognition_stream", "message_data": self.buffer})
        self.send_queue.put(data)

    def begin_retrieval(self, stop_event) -> None:
        while not stop_event.is_set():
            self.send_data()
            time.sleep(0.1)


if __name__ == "__main__":
    speech_stream = SpeechRecognitionStream()
    speech_stream.start_thread()

    # Example loop to get messages from the queue
    try:
        while True:
            if not speech_stream.send_queue.empty():
                message = speech_stream.send_queue.get()
                print("Received message:", message)
            time.sleep(1)
    except KeyboardInterrupt:
        speech_stream.stop_thread()
