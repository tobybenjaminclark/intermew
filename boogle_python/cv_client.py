import os
import socket
import threading
from queue import Queue
import json
import shutil


class GMS2Client():
    stop_event: threading.Event     # Event to signal the termination of the thread.
    client_queue: Queue             # Queue to transfer data from the subthread to the main thread.
    thread: threading.Thread        # Client thread to maintain client-server connection.

    def __init__(self, parent):
        """
        Initializes stop event & client queue
        """

        self.host = "127.0.0.1"
        self.port = 36042
        self.connected = False


        # Create an event to signal the subthreads to safely stop execution.
        self.stop_event = threading.Event()

        self.client_queue = Queue()

        self.replies_queue = parent.client_replies_queue


    def start_thread(self) -> None:
        """
        Initialise & Start the Client thread.
        """
        self.create_thread()

    def create_thread(self) -> threading.Thread:
        """
        Create the Client thread.
        Returns: the client thread instance.
        """
        self.thread = threading.Thread(target=self.handle_connection_tcp, args=(self.stop_event,))
        self.thread.start()



    
    def stop_thread(self) -> None:
        """
        Stop the client thread using the stop_event.
        """

        self.stop_event.set()
        self.thread.join()

    def handle_connection_tcp(self, stop_event:threading.Event) -> bool:
        """
        Initialise the connection to the server.
        Handle message transmission between the client and server.

        Args:
            client_queue: A Queue shared between the client thread and controller. Stores messages to be sent from the client to the server.
            stop_event: A threading.Event instance that will be set once the thread should terminate.
        """

        # Initialise the socket and bind it to the specified host, at the specified port.
        sock: socket.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        sock.bind(( self.host, int(self.port) ))
        print("listening")
        sock.listen()

        # Attempt connection to the server.
        try:
            conn: socket.socket
            conn, _ = sock.accept()
            self.connected = True

            with conn:  
                self.mainloop(self.stop_event, conn)

        # Handle socket timeout
        except socket.timeout:
            print("Failed to connect to GMS2 due to timeout.\nTry increasing timeout length in settings.ini")
            return False
        except Exception as e:
            raise e
        



    def mainloop(self, stop_event: threading.Event, conn: socket.socket) -> None:
        """
        Send messages to the GMS2 server if any are queued, and receive messages from the server.
        """

        print(f"conn: {conn}")
        conn.settimeout(0.1)  # Set a small timeout to avoid blocking on recv
        while not stop_event.is_set():
            # Send messages if any are queued
            if not self.client_queue.empty():
                data: str = self.client_queue.get()
                conn.send(bytes(str(data), encoding="UTF-8"))
            
            # Try to receive messages from the server
            try:
                incoming_data = conn.recv(1024)  # Adjust buffer size as needed
                if incoming_data:
                    # Decode the incoming data as latin1
                    decoded_data = incoming_data.decode('latin1')
                    try:
                        # Find the start of the JSON
                        json_start = decoded_data.find('{')
                        # Find the last closing brace
                        json_end = decoded_data.rfind('}') + 1

                        if json_start != -1 and json_end != -1 and json_end > json_start:
                            # Extract the JSON portion of the data
                            json_data = decoded_data[json_start:json_end]

                            # Attempt to load the JSON data
                            parsed_json = json.loads(json_data)

                            self.handle_reply(parsed_json)
                            
                    except json.JSONDecodeError as e:
                        print(f"Error decoding JSON: {e}")
                        os._exit(0)
                    
            except socket.timeout:
                # Timeout happens when no data is received, we just continue the loop
                pass

            except Exception as e:
                print(f"socket exception: {e}")
                os._exit(0)
            
        return None
    
    def handle_reply(self, parsed_json:dict[str,any]) -> None:
        self.replies_queue.put(parsed_json)



                    