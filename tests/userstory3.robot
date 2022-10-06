*** Settings ***
Documentation    Test upload csv file API
Library     RequestsLibrary
Library     Collections
Library     ./test-library/upload_files.py
Test Setup  Create API Session
Test Teardown   Delete Test Data and Sessions

*** Variables ***
${base_url}     http://localhost:8080
${success_status_code}      200
${success_message}      Successfully uploaded
${server_error_status_code}     500
${client_error_status_cdoe}     400

*** Keywords ***
Create API Session
    create session    uploadsession   ${base_url}

Delete Test Data and Sessions
    POST On Session   uploadsession   /calculator/rakeDatabase
    Delete All Sessions

All working class hero data should be inserted in system
    [Arguments]  ${actual_status_code}
    ${actual_status_code}=      Convert To String   ${actual_status_code}
    Should Be Equal     ${actual_status_code}       ${success_status_code}

All working class hero data should not be inserted in system
    [Arguments]  ${actual_status_code}
    ${actual_status_code}=      Convert To String   ${actual_status_code}
    Should Not Be Equal     ${actual_status_code}       ${success_status_code}

*** Test Cases ***
#TC0:Upload valid csv file to insert record of working class hero (POST)
#    ${file}=    Get Binary File   E:\\Assignment\\oppenheimer-project-test\\testdata\\valid_test_data_file.csv
#    ${files}=    CREATE DICTIONARY    file    ${file}
#    ${header}=  create dictionary     Accept=text/plain   Content-Type=multipart/form-data
#    ${response}=    POST On Session     uploadsession   calculator/uploadLargeFileForInsertionToDatabase    headers=${header}   data=${files}

TC1: Should upload valid csv file to insert record of working class hero (POST)
    ${file_path}=     Get valid csv file
    ${response_status_code}=    Upload file     ${file_path}
    Log      ${response_status_code}
    All working class hero data should be inserted in system    ${response_status_code}

TC2:Should upload only heading csv file to insert record of working class hero (POST)
    ${file_path}=     Get only heading csv file
    ${response_status_code}=    Upload file     ${file_path}
    Log      ${response_status_code}
    All working class hero data should be inserted in system    ${response_status_code}

TC3:Should not upload Empty csv file to insert record of working class hero (POST)
    ${file_path}=   Get empty csv file
    ${response_status_code}=    Upload file     ${file_path}
    Log     ${response_status_code}
    All working class hero data should not be inserted in system    ${response_status_code}

TC4:Should not upload without heading csv file to insert record of working class hero (POST)
    ${file_path}=   Get empty csv file
    ${response_status_code}=    Upload file     ${file_path}
    Log     ${response_status_code}
    All working class hero data should not be inserted in system    ${response_status_code}

TC5:Should not upload non csv file to insert record of working class hero (POST)
    ${file_path}=   get non csv file
    ${response_status_code}=    Upload file     ${file_path}
    Log     ${response_status_code}
    All working class hero data should not be inserted in system    ${response_status_code}

TC6:Should not upload disturbed column sequence csv file to insert record of working class hero (POST)
    ${file_path}=   Get disturbed column csv file
    ${response_status_code}=    Upload file     ${file_path}
    Log     ${response_status_code}
    All working class hero data should be inserted in system    ${response_status_code}

TC7:Should not upload missing column csv file to insert record of working class hero (POST)
    ${file_path}=   Get missing column csv file
    ${response_status_code}=    Upload file     ${file_path}
    Log     ${response_status_code}
    All working class hero data should not be inserted in system    ${response_status_code}

TC8:Should not upload missing intermittent row csv file to insert record of working class hero (POST)
    ${file_path}=   Get intermittent row csv file
    ${response_status_code}=    Upload file     ${file_path}
    Log     ${response_status_code}
    All working class hero data should not be inserted in system    ${response_status_code}
