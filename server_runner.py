from boogle_python.controller import Controller
from boogle_python.misc.jobs_scrape import JobsScraper


if __name__ == "__main__": 
    jobscraper = JobsScraper()
    jobscraper.retrieve_jobs()

    """controller = Controller()
    controller.mainloop()"""
                