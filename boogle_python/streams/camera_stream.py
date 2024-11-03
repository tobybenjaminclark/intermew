
from queue import Queue
import threading
import json
import time
import cv2
import base64


class CameraStream():
    stop_event: threading.Event      # Event to signal the termination of the thread.
    send_queue: Queue             # Queue to transfer data from the subthread to the main thread.

    def __init__(self):
        """
        Initialise the stop event and queue.
        """

        self.frame = None


        # Create an event to signal the subthreads to safely stop execution.
        self.stop_event: threading.Event = threading.Event()
        self.send_queue = Queue()

        self.new_data = False
        self.frame = None
        self.exists = False


    def start_thread(self) -> None:
        self.exists = True
        self.event = threading.Event()
        self.create_thread()
        
    def create_thread(self) -> threading.Thread:

        # ',' used in thread args to convert the single argument to a tuple.
        self.thread: threading.Thread
        self.thread = threading.Thread(
            target=self.begin_retrieval, args=(self.stop_event,)
        )
        self.thread.start()


    def stop_thread(self) -> None:

        self.stop_event.set()
        self.exists = False
        self.thread.join()


    def send_data(self, data) -> None:

        data_json = json.dumps(data)
        self.send_queue.put(data_json)
    

    def begin_retrieval(self, stop_event) -> None:

        
        while not stop_event.is_set():

            if not self.new_data: continue
            

            # Encode the image to JPEG format
            _, buffer = cv2.imencode('.jpg', self.frame, [int(cv2.IMWRITE_JPEG_QUALITY), 10])

            # Convert to base64 for JSON compatibility
            frame_base64 = base64.b64encode(buffer).decode('utf-8')

            # Construct JSON payload
            image_json = {
                "from": "camera_stream",
                "image_data": frame_base64,
                "format": "jpg"
            }

            self.send_data(image_json)
            self.new_data = False
            time.sleep(0.15)
            
    