# oppenheimer-project-test

### How to run these

- Preferred OS windows
- Install pycharm to read this code
- Install python 3.9
- Install pip

### Prerequisite

Run oppenheimer web application using given jar file in assignment question

### Functional tests

Setup:

1. pip install robotframework
2. pip install robotframework-jsonlibrary
3. pip install robotframework-requests

Test Execution:
- Go to code directory ./oppenheimer-project-test
- Open bash terminal here
- Run below command to execute API tests
  - ./test-run.sh
- Run below command to execute UI tests
  - ./test-run-UI.sh
- Please refer logs in ./output and ./output-UI folders to check test logs

### Non Functional tests

##### Performance & Load tests

Setup:
- Install locust using below command
  - pip install locust
  
Test execution:
- open bash terminal and run below script
  - ./performance-testing.sh
- open chrome browser and enter url - http://localhost:8089/
- Enter below parameteres - 
  - NUmber of users = 2000
  - Spawn rate = 20
  - Host = http://localhost:8080
- CLick on Start swarming

After some time you will see requests failures in statistics that is the application breaking point we can consider.
We can refer charts and metrics in statistics to make thorough analysis on application responsiveness and slowness.

##### Security test
Setup:
- Install ZAP from here - https://www.zaproxy.org/download/
- you will need java runtime environment (jre) to run this application

Test execution:
- Open ZAP application
- put application url and do auto attack 
- this will detect potential security vulnerabilities on application.
- ZAP shows all details about application on its UI.



