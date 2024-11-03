

import json
from openai import OpenAI
import openai
from boogle_python.speech.tts import TTS
import threading
import time


class PromptGenerator():
    def __init__(self, queue):
        self.counter = -1
        self.interview_length = 1
        self.queue = queue
        self.tts = TTS(queue)

        
        with open('boogle_python/key.txt', 'r') as file:
            key = file.read().strip()

        self.client = OpenAI(api_key=key)

    
    def generate_prompt(self, inp: str) -> str:

        self.counter +=1 

        if self.counter == 0:

            self.log = []

            # Formulate the initial prompt with job description details
            prompt = (
                f"Begin an interview with the candidate for the following position:\n\n{inp}\n\n"
                "Start with a greeting and an initial interview question."
            )
            
            response = self.client.chat.completions.create(
                model="gpt-4",
                messages=self.context + [{"role": "assistant", "content": prompt}]
            )

            print(response.choices[0].message)
            initial_message = response.choices[0].message.content
            self.context.append({"role": "assistant", "content": initial_message})
            reply = {
                "from": "interviewer",
                "message_data": initial_message
            }

            


        elif self.counter < self.interview_length:

            self.log.append(inp)
            # Add user response to context
            self.context.append({"role": "user", "content": inp})
            
            # Generate the follow-up question
            response = self.client.chat.completions.create(
                model="gpt-4",
                messages=self.context
            )

            prompt = (
                f"The candidate has replied {inp}. How do you respond? Keep your response short and ask a question."
            )
            
            follow_up_question = response.choices[0].message.content
            self.context.append({"role": "assistant", "content": follow_up_question})
            reply = {
                "from": "interviewer",
                "message_data": follow_up_question
            }
        
        else:
            reply = {
                "from": "end_interviewer",
                "message_data": "Thank you!"
            }

        thread = threading.Thread(target=self.tts.speak, args=(reply["message_data"],))
        thread.start()

        self.log.append(reply)
        
        time.sleep(2)
        self.send_data(reply)
        
    def send_data(self, data) -> None:
        data_json = json.dumps(data)
        self.queue.put(data_json)
        
    def start_interview(self, file_location: str):
        # read the file contents (interview)
        with open(file_location, "r") as f:
            contents = f.read()

            # Initialize context with system prompt
        self.context = [
            {"role": "system", "content": f"Keep your reply short. Format your response. The candidate has applied for a position with the following details: {contents}. You are interviewing them for the role."}
        ]

        self.generate_prompt(contents)
        
        
if __name__ == "__main__":
    prompt_generator = PromptGenerator()
    prompt_generator.generate_prompt("what a lovely day")
