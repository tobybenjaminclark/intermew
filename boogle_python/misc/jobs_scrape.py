
import json
import os
from jobspy import scrape_jobs
import csv
import numpy as np
from boogle_python.misc.prompt_generator import PromptGenerator



class JobsScraper():
    def __init__(self):
        self.prompt_generator = PromptGenerator()
        pass
        
    
    def retrieve_jobs(self, search_term="software engineer"):
        jobs = scrape_jobs(
            site_name=["indeed", "glassdoor", "google"],
            search_term=search_term,
            google_search_term="software engineer jobs near Durham, United Kingdom since yesterday",
            location="Durham, United Kingdom",
            results_wanted=20,
            hours_old=72,
            country_indeed='UK',
            
            # linkedin_fetch_description=True # gets more info such as description, direct job url (slower)
            # proxies=["208.195.175.46:65095", "208.195.175.45:65095", "localhost"],
        )
        print(f"Found {len(jobs)} jobs")
        print(jobs.head())

        print(jobs)

        output_dir = "game/datafiles"

        # TEMP HARDCODING FOR INTERVIEWS
        interviews = [
            {
                "name": "Preliminary Round",
                "type": "Technical",
                "score": 0
            },
            {
                "name": "Personal",
                "type": "HR",
                "score": 0,
            },
            {
                "name": "Technical Interview",
                "type": "Managerial",
                "score": 0,
            }
        ]
        

        for index, job in jobs.iterrows():


            title = job["title"]
            description = job["description"]
            description = self.prompt_generator.shorten_description(description)
            company = job["company"]
            job_url = job["job_url"]
            is_remote = job["is_remote"]

            job_info = {
                "position": title,
                "name": company,
                "description": description,
                "url": job_url,
                "is_remote": is_remote,
                "interviews": interviews
            }

            # Create a safe filename using the job title
            safe_title = job["title"].replace(" ", "_").replace("/", "_")  # Replace spaces and slashes
            filename = f"{safe_title}_{index}.json"  # Include index to ensure uniqueness
            file_path = os.path.join(output_dir, filename)

            # Write the job info to a JSON file
            with open(file_path, 'w') as json_file:
                json.dump(job_info, json_file, indent=4)

            print(f"Job information written to {file_path}")

            


            print('-' * 40)

if __name__ == "__main__":
    jobscraper = JobsScraper()
    jobscraper.retrieve_jobs()