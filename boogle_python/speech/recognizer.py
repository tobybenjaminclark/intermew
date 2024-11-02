from RealtimeSTT import AudioToTextRecorder

class SpeechRecognition:

    def __init__(self):
        self.recorder = AudioToTextRecorder()

    

    def print_text(self, text):
        print(text)

    def process_text(self):
        while 1:
            self.recorder.text(self.print_text)
        
if __name__ == '__main__':
    sr = SpeechRecognition()
    sr.process_text()