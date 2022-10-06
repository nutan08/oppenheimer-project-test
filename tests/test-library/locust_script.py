import time
from locust import HttpUser, between, task
from upload_files import get_valid_csv_file, get_empty_csv_file, get_non_csv_file, get_only_heading_csv_file


class WebsiteUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def get_tax_relief_API(self):
        self.client.get(url="/calculator/taxRelief")

    @task
    def insert_single_record(self):
        emp_record = {"birthday": "25022017", "gender": "M", "name": "Jhon", "natid": "oknm4sfdvc", "salary": "63", "tax": "11.5"}
        self.client.post(url="/calculator/insert", json=emp_record)

    @task
    def upload_employee_record_file(self):
        self.client.post(url="/calculator/uploadLargeFileForInsertionToDatabase", files=get_non_csv_file())
