import json
from boogle_python.cv_client import GMS2Client
from boogle_python.test_stream import TestStream
from boogle_python.camera_stream import CameraStream
from boogle_python.emotion_stream import EmotionStream
from queue import Queue
import cv2

class Controller:
    def __init__(self) -> None:
        self.client_replies_queue = Queue()
        self.stream_instances = {}  # Store stream instances and their queues
        self.running = True

        self.create_client()
        self.initialize_streams()
        
    def create_client(self) -> None:
        """Creates a thread which initializes the client."""
        self.client = GMS2Client(self)
        self.client_queue = self.client.client_queue
        self.client.start_thread()

    def initialize_streams(self) -> None:
        """Initializes the test and camera streams."""
        self.create_stream('test_stream', TestStream)
        self.create_stream('camera_stream', CameraStream)
        self.create_stream('emotion_stream', EmotionStream)

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
        try:
            self.try_transmit_to_client()
        except KeyboardInterrupt:
            self.terminate_program()
        except Exception as e:
            raise e
    
    def terminate_program(self) -> None:
        """Safely end all threads and terminate the main process."""
        print("CTRL+C has been pressed. Ending threads.")
        for stream_info in self.stream_instances.values():
            stream_info['instance'].stop_thread()  # Stop the thread using the instance
        self.client.stop_thread()
        self.running = False

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
            print(f"replies: {replies_dict}")
            self.handle_client_replies(replies_dict)
            return True
        return False

    def handle_client_replies(self, replies_dict) -> None:
        """Handles replies from the client and manages thread states."""
        if "from" in replies_dict:
            stream_name = replies_dict["from"]  # Extract stream name
            print(f"stream instances: {self.stream_instances}")
            if stream_name in self.stream_instances:
                stream_instance = self.stream_instances[stream_name]['instance']
                match replies_dict["status"]:
                    case "create":
                        stream_instance.start_thread()  # Call start_thread on the instance
                    case "destroy":
                        stream_instance.stop_thread()  # Call stop_thread on the instance
