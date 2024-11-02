
from jobspy import scrape_jobs
import csv
import numpy as np


class JobsScraper():
    def __init__(self):
        pass
        
    
    def retrieve_jobs(self, search_term="software engineer"):
        jobs = scrape_jobs(
            site_name=["indeed", "linkedin", "glassdoor", "google"],
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

        for index, job in jobs.iterrows():

            title = job["title"]
            description = job["description"]
            company = job["company"]
            job_url = job["job_url"]
            is_remote = job["is_remote"]

            if description == np.nan:
                print("nan :(")

            


            print('-' * 40)

if __name__ == "__main__":
    jobscraper = JobsScraper()
    jobscraper.retrieve_jobs()