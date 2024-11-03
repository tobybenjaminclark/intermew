import threading
import json
import time
from queue import Queue
import wave
import numpy as np
import sounddevice as sd
import io
from openai import OpenAI
import soundfile as sf
from moviepy.editor import AudioFileClip
import os

class SpeechRecognitionStream:
    def __init__(self):
        """
        Initialize the stop event and queue.
        """
        self.stop_event = threading.Event()
        self.send_queue = Queue()
        self.buffer = ""
        self.thread = None
        self.exists = False
        with open('boogle_python/key.txt', 'r') as file:
            self.key = file.read().strip()

        self.client = OpenAI(api_key=self.key)

    def start_thread(self) -> None:
        """Start the speech recognition thread."""
        if self.thread is None or not self.thread.is_alive():
            self.exists = True
            self.stop_event = threading.Event()
            self.create_thread()

    def create_thread(self) -> None:
        """Create and start the recognition thread."""
        self.thread = threading.Thread(target=self.begin_retrieval)
        self.thread.start()

    def stop_thread(self) -> None:
        """Stop the speech recognition thread."""
        self.stop_event.set()
        if self.thread is not None:
            self.thread.join()

    def record_audio(self, duration=10, fs=44100, filename='output.mp4'):
        """Record audio for a specified duration and sample rate, then save it as an MP4 file."""
        print("Recording audio...")
        audio = sd.rec(int(duration * fs), samplerate=fs, channels=1, dtype='float64')
        sd.wait()  # Wait until recording is finished

        # Convert audio data to the appropriate format for saving
        audio = (audio * 32767).astype(np.int16)  # Convert float to int16

        # Save the audio as a WAV file first (required for MoviePy)
        wav_filename = filename.replace('.mp4', '.wav')
        sf.write(wav_filename, audio, fs)

        # Use MoviePy to create an MP4 file from the WAV file
        audio_clip = AudioFileClip(wav_filename)
        audio_clip.write_audiofile(filename, codec='aac')

        # Clean up the temporary WAV file
        os.remove(wav_filename)

        return filename

    def transcribe_audio(self, audio_path) -> str:
        """Transcribe audio from a file using OpenAI Whisper."""
        with open(audio_path, 'rb') as f:  # Open the file in binary mode
            # Use OpenAI Whisper for transcription
            response = self.client.audio.transcriptions.create(
                model="whisper-1",
                file=f
            )

            print(response)

            return response.text



    def process_text(self, text: str) -> None:
        """Process the recognized text and send it to the queue."""
        self.buffer += " " + text
        data = json.dumps({"from": "speech_recognition_stream", "message_data": self.buffer.strip()})
        self.send_queue.put(data)

    def begin_retrieval(self) -> None:
        """Continuously retrieve speech data until the stop event is set."""
        while not self.stop_event.is_set():
            audio = self.record_audio()
            text = self.transcribe_audio(audio)
            if text:
                self.process_text(text)
            time.sleep(0.1)


if __name__ == "__main__":
    speech_stream = SpeechRecognitionStream()
    api_key = speech_stream.key  # Replace with your OpenAI API key
    
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
