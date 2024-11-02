
from pathlib import Path
from openai import OpenAI


class TTS():
    def __init__(self):
        

        self.speech_file_path = "speech.mp3"

        with open('boogle_python/key.txt', 'r') as file:
            key = file.read().strip()

        self.client = OpenAI(api_key=key)

    def speak(self, text):
        with self.client.audio.speech.with_streaming_response.create(
            model="tts-1",
            voice="alloy",
            input=text,
        ) as response:
            response.stream_to_file(self.speech_file_path)

        

if __name__ == "__main__": 
    tts = TTS()
    tts.speak("Welcome to your job interview. Can you tell me about yourself?")

