*** Settings ***
Documentation    Test insert more than one working class employee via an API
Library     RequestsLibrary
Library     Collections
Test Setup  Create API Session
Test Teardown   Delete Test Data and Sessions

*** Variables ***
${base_url}     http://localhost:8080
&{header}   content-type=application/json

*** Keywords ***
Create API Session
    create session    insertsession   ${base_url}

Delete Test Data and Sessions
    POST On Session   insertsession   /calculator/rakeDatabase
    Delete All Sessions

*** Test Cases ***
TC1:Should insert multiple record of working class hero (POST)
    ${emp1}=    create dictionary    birthday=02021956    gender=f  name=minny    natid=hyjukitrfe     salary=50000     tax=880
    ${emp2}=    create dictionary    birthday=25021993    gender=m  name=jin    natid=gthhyujkio     salary=55652     tax=8852
    ${body}=    create list     ${emp1}     ${emp2}
    ${response}=    POST On Session    insertsession     /calculator/insertMultiple     json=${body}    headers=${header}   expected_status=202
    log to console    ${response.status_code}
    log to console    ${response.content}

TC2:Should insert multiple record of working class hero (POST)
    ${emp1}=    create dictionary    birthday=02021956    gender=f  name=minny    natid=hyjukitrfe     salary=50000     tax=880
    ${body}=    create list     ${emp1}
    ${response}=    POST On Session    insertsession     /calculator/insertMultiple     json=${body}    headers=${header}   expected_status=202
    log to console    ${response.status_code}
    log to console    ${response.content}

TC3:Should not insert duplicate multiple record of working class hero (POST)
    ${emp1}=    create dictionary    birthday=02021956    gender=f  name=minny    natid=hyjukitrfe     salary=50000     tax=880
    ${emp2}=    create dictionary    birthday=25021993    gender=m  name=jin    natid=hyjukitrfe     salary=55652     tax=8852
    ${body}=    create list     ${emp1}     ${emp2}
    ${first_response}=    POST On Session    insertsession     /calculator/insertMultiple     json=${body}    headers=${header}   expected_status=202
    ${second_response}=    POST On Session    insertsession     /calculator/insertMultiple     json=${body}    headers=${header}   expected_status=500

TC4:Should not insert empty list of working class hero (POST)
    ${body}=    create list
    ${response}=    POST On Session    insertsession     /calculator/insertMultiple     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC5:Should not insert empty employee records of working class hero in list format(POST)
    ${emp1}=    create dictionary
    ${emp2}=    create dictionary
    ${body}=    create list     ${emp1}     ${emp2}
    ${response}=    POST On Session    insertsession     /calculator/insertMultiple     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC6:Should not insert single record of working class hero in wrong format (POST)
    ${body}=    create dictionary    birthday=02021956    gender=f  name=minny    natid=hyjukitrfe     salary=50000     tax=880
    ${response}=    POST On Session    insertsession     /calculator/insertMultiple     json=${body}    headers=${header}   expected_status=400
    log to console    ${response.status_code}
    log to console    ${response.content}

