
from queue import Queue
import threading
import json
from RealtimeSTT import AudioToTextRecorder
import time

class SpeechRecognitionStream():
    stop_event: threading.Event      # Event to signal the termination of the thread.
    send_queue: Queue             # Queue to transfer data from the subthread to the main thread.

    def __init__(self):
        """
        Initialise the stop event and queue.
        """

        # Create an event to signal the subthreads to safely stop execution.
        self.stop_event: threading.Event = threading.Event()
        self.send_queue = Queue()

        self.recorder = AudioToTextRecorder()
        
        self.exists = False



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

        self.recorder.text(self.process_text)

        # get speech
        self.new_data = False

        

    def process_text(self, text):
        try:
            data = json.dumps({"from": "speech_recognition_stream", "message_data": text})
            self.send_queue.put(data)
        except Exception as e:
            print(e)
    

            

    def begin_retrieval(self, stop_event) -> None:

        while not stop_event.is_set():
            self.send_data()
            time.sleep(0.1)




if __name__ == "__main__":
    pass