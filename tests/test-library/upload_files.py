from robot.api.deco import keyword
import requests
import os


# class Keywords:
#    def __init__(self):
#        self.robot_builtin = BuiltIn()
#        self.session = requests.session()

@keyword("Get valid csv file")
def get_valid_csv_file():
    testdataFilepath = os.path.join(os.getcwd(), "testdata", "valid_test_data_file.csv")
    return testdataFilepath

@keyword("Get only heading csv file")
def get_only_heading_csv_file():
    testdataFilepath = os.path.join(os.getcwd(), "testdata", "only_headings_test_data_file.csv")
    return testdataFilepath

@keyword("Get empty csv file")
def get_empty_csv_file():
    testdataFilepath = os.path.join(os.getcwd(), "testdata", "empty_test_data_file.csv")
    return testdataFilepath

@keyword("Get without heading csv file")
def get_without_heading_csv_file():
    testdataFilepath = os.path.join(os.getcwd(), "testdata", "without_headings_test_data_file.csv")
    return testdataFilepath

@keyword("Get non csv file")
def get_non_csv_file():
    testdataFilepath = os.path.join(os.getcwd(), "testdata", "text_file.txt")
    return testdataFilepath

@keyword("Get disturbed column csv file")
def get_disturbed_column_csv_file():
    testdataFilepath = os.path.join(os.getcwd(), "testdata", "disturbed_column_sequence_test_data_file.csv")
    return testdataFilepath

@keyword("Get missing column csv file")
def get_missing_column_csv_file():
    testdataFilepath = os.path.join(os.getcwd(), "testdata", "missing_column_test_data_file.csv")
    return testdataFilepath

@keyword("Get intermittent row csv file")
def get_intermittent_row_csv_file():
    testdataFilepath = os.path.join(os.getcwd(), "testdata", "missing_intermittent_rows_test_data_file.csv")
    return testdataFilepath

#UPLOAD
@keyword("Upload file")
def upload_file(testdataFilepath):
    files = {'file': open(testdataFilepath, 'r')}
    response = requests.post('http://localhost:8080/calculator/uploadLargeFileForInsertionToDatabase', files=files)
    return response.status_code

# if __name__ == '__main__':
#    keywords = Keywords()
#    keywords.get_valid_csv_file()
