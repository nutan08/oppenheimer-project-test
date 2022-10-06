from locust import HttpUser, between, task, log

class WebsiteUser(HttpUser):
    
    wait_time = between(1, 5)
    
    # @task
    # def insert_random(self):
    #     insert_data_count = random.randint(1, 100)
    #     self.client.post(url="/calculator/insertRandomToDatabaseForNoReason?count={}".format(100))

    @task
    def get_tax_relief_API(self):
        tax_relief_response = self.client.get(url="/calculator/taxRelief")
        tax_relief_summary_response = self.client.get(url="/calculator/taxReliefSummary")
        if tax_relief_response.status_code == 200 and tax_relief_summary_response.status_code == 200:
            print("get tax relief Success!")
        else:
            print("get tax relief Failed! status codes: {} & {}".format(tax_relief_response.status_code, tax_relief_summary_response.status_code))

    @task
    def insert_single_record(self):
        emp_record = {"birthday": "25022017", "gender": "M", "name": "Jhon", "natid": "oknm4sfdvc", "salary": "63", "tax": "11.5"}
        response = self.client.post(url="/calculator/insert", json=emp_record)
        if response.status_code == 202:
            print("Insert Single Record Success!")
        else:
            print("Insert Single Record Failed!")

    # @task
    # def upload_employee_record_file(self):
    #     valid_file_path = get_valid_csv_file()
    #     files = {'file': open(valid_file_path, 'r')}
    #     self.client.post(url="/calculator/uploadLargeFileForInsertionToDatabase", files=files)

    @task
    def insert_multiple_records(self):
        emp1_record = {"birthday": "25022017", "gender": "M", "name": "Jhon", "natid": "oknm4sfdvc", "salary": "83917", "tax": "19300.91"}
        emp2_record = {"birthday": "25062004", "gender": "F", "name": "Monica", "natid": "uPDYa2a_Ec", "salary": "98492", "tax": "22653.16"}
        emp3_record = {"birthday": "10081987", "gender": "M", "name": "Richard", "natid": "Y5k6PcwBko", "salary": "21554", "tax": "4957.42"}
        emp_record_list = [emp1_record, emp2_record, emp3_record]
        response = self.client.post(url="/calculator/insertMultiple", json=emp_record_list)
        if response.status_code == 200:
            print("insert multiple Success!")
        else:
            print("insert multiple Failed! status codes: {} & {}".format(response.status_code))

