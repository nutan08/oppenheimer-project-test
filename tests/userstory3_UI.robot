*** Settings ***
Library    SeleniumLibrary
Library     RequestsLibrary
Test Setup  Create Chrome Driver And Open Url
Test Teardown   Clean Up Data And Close Browser
Library     ./test-library/upload_files.py

*** Variables ***
${url}      http://localhost:8080/
${browser}      chrome
${valid_file_path}      Get valid csv file
# we can test this on different browsers here I am only testing in chrome driver

*** Keywords ***
Create Chrome Driver And Open Url
    Create Webdriver    Chrome
    Go To   ${url}
    maximize browser window

Clean Up Data And Close Browser
    create session    rakedbsession   ${url}
    POST On Session   rakedbsession   /calculator/rakeDatabase
    Close All Browsers

*** Test Cases ***
TC1: Upload valid csv file to portal should populate working class heros in system
    log     ${valid_file_path}
    Wait Until Element is Enabled   xpath://body/div[1]/div[2]/div[1]/div[1]/div[2]/input[1]    60
    Choose File     xpath://body/div[1]/div[2]/div[1]/div[1]/div[2]/input[1]     ${EXECDIR}${/}\\testdata\\valid_test_data_file.csv
    #Wait Until Element is Enabled   xpath://button[contains(text(),'Refresh Tax Relief Table')]     60
    Click Button    xpath://button[contains(text(),'Refresh Tax Relief Table')]
    Execute JavaScript    window.scrollTo(0,6000)
    sleep   2
    ${elem} =   Element Text Should Be      xpath:/html[1]/body[1]/div[1]/div[2]/div[1]/div[3]/div[1]/p[1]      £645357.35 will be dispensed to 28 Working Class Hero/s      timeout=5
#    ${rowLocator}=  Get Webelements  tag:tr
#    ${rowCount}=     Get Element Count   ${rowLocator}
#    Log     ${rowCount}

TC2:Upload only heading csv file to insert record of working class hero (POST)
    Wait Until Element is Enabled   xpath://body/div[1]/div[2]/div[1]/div[1]/div[2]/input[1]    60
    Choose File     xpath://body/div[1]/div[2]/div[1]/div[1]/div[2]/input[1]     ${EXECDIR}${/}\\testdata\\only_headings_test_data_file.csv
    Click Button    xpath://button[contains(text(),'Refresh Tax Relief Table')]
    Execute JavaScript    window.scrollTo(0,6000)
    sleep   2
    ${elem} =   Element Text Should Be      xpath:/html[1]/body[1]/div[1]/div[2]/div[1]/div[2]/div[1]/p[1]      £0 will be dispensed to 0 Working Class Hero/s      timeout=5
    Log      ${elem}

TC3:Upload empty csv file to portal should not populate working class heros in system
    Wait Until Element is Enabled   xpath://body/div[1]/div[2]/div[1]/div[1]/div[2]/input[1]    60
    Choose File     xpath://body/div[1]/div[2]/div[1]/div[1]/div[2]/input[1]     ${EXECDIR}${/}\\testdata\\empty_test_data_file.csv
    Wait Until Element is Enabled   xpath://button[contains(text(),'Refresh Tax Relief Table')]     60
    Click Button    xpath://button[contains(text(),'Refresh Tax Relief Table')]
    Execute JavaScript    window.scrollTo(0,500)
    sleep   2
    Element Text Should Be      xpath:/html[1]/body[1]/div[1]/div[2]/div[1]/div[2]/div[1]/p[1]      £0 will be dispensed to 0 Working Class Hero/s      timeout=5

TC4:Uploading text file should not populate working class heros in system
    Wait Until Element is Enabled   xpath://body/div[1]/div[2]/div[1]/div[1]/div[2]/input[1]    60
    Choose File     xpath://body/div[1]/div[2]/div[1]/div[1]/div[2]/input[1]     ${EXECDIR}${/}\\testdata\\text_file.txt
    Wait Until Element is Enabled   xpath://button[contains(text(),'Refresh Tax Relief Table')]     60
    Click Button    xpath://button[contains(text(),'Refresh Tax Relief Table')]
    Execute JavaScript    window.scrollTo(0,500)
    sleep   2
    Element Text Should Be      xpath:/html[1]/body[1]/div[1]/div[2]/div[1]/div[2]/div[1]/p[1]      £0 will be dispensed to 0 Working Class Hero/s      timeout=5

# likewise we can write test for all other files available in testdata directory




