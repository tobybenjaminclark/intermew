

import os
from openai import OpenAI
from pydub import AudioSegment
from pydub.playback import play
import json


class TTS():
    def __init__(self, queue):
        
        self.speech_file_path = "speech.mp3"

        with open('boogle_python/key.txt', 'r') as file:
            key = file.read().strip()

        self.client = OpenAI(api_key=key)

        self.queue = queue

    def speak(self, text):

        with self.client.audio.speech.with_streaming_response.create(
            model="tts-1",
            voice="alloy",
            input=text,
        ) as response:
            response.stream_to_file(self.speech_file_path)

        # Load the MP3 file
        speech = AudioSegment.from_mp3(self.speech_file_path)


        # Play the MP3 file
        play(speech)

        print("added to q")
        self.queue.put(json.dumps({"from": "speech_recognition_stream", "action": "done"}))
        print("done adding to q")
        print(self.queue)
        


        

if __name__ == "__main__": 
    tts = TTS()
    tts.speak("Welcome to your job interview. Can you tell me about yourself?")

