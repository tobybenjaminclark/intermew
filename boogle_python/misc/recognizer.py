import speech_recognition as sr

class SpeechRecognizer:

    def __init__(self):
        self.recognizer = sr.Recognizer()

    def recognize_speech(self):
        
        with sr.Microphone() as source:
            print("Listening...")
            audio = self.recognizer.listen(source)

        try:
            text = self.recognizer.recognize_google(audio)
            print(f"You said: {text}")
            return text
        except sr.UnknownValueError:
            print("Sorry, I could not understand the audio.")
            return None
        except sr.RequestError:
            print("Could not request results from Google Speech Recognition service.")
            return None

if __name__ == "__main__":
    speech = SpeechRecognizer()
    user_response = speech.recognize_speech()
