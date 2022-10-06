*** Settings ***
Documentation    Test insert a single record of working class employee via an API
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

TC1:Should insert valid single record of working class hero (POST)
    ${body}=    create dictionary    birthday=01111982    gender=M  name=Jay    natid=gthyjukilo     salary=255444     tax=4454
    log to console  ${body}
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=202
    log to console    ${response.status_code}
    log to console    ${response.content}

#    #Validation
#    ${status_code}=  convert to string    ${response.status_code}
#    should be equal    ${status_code}   202

TC2: Should not insert null single record of working class hero (POST)
    ${body}=    create dictionary    birthday=null    gender=null  name=null    natid=null     salary=null     tax=null
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}  expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC3:Should not insert empty string single record of working class hero (POST)
    ${body}=    create dictionary    birthday=    gender=  name=    natid=     salary=     tax=
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC4:Should not insert partial valid single record of working class hero (POST)
    ${body}=    create dictionary    birthday=01111982  gender=M    name=Jay
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}  expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC5:Should not insert invalid single record of working class hero (POST)
    ${body}=    create dictionary    birthday=0112665    gender=m  name=john    natid=2525     salary=dummy_salary     tax=dummy_tax
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC6:Should insert single record of working class hero with salary and/or tax in number (POST)
    ${salary}=    Convert To Number   22000
    ${tax}=    Convert To Number   2000
    ${body}=    create dictionary    birthday=25021993    gender=m  name=john    natid=gthhyujkio     salary=${salary}     tax=${tax}
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=202
    log to console    ${response.status_code}
    log to console    ${response.content}

TC7:Should not insert single record of working class hero with invalid birthday format in DD/MM/YYYY (POST)
    ${date}=    Convert To String   30/01/1993
    ${body}=    create dictionary    birthday=${date}    gender=m  name=john    natid=gthhyujkio     salary=25222     tax=2000
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC8:Should not insert single record of working class hero with invalid birthday format in DD-MM-YYYY (POST)
    ${date}=    Convert To String   30-01-1993
    ${body}=    create dictionary    birthday=${date}    gender=m  name=john    natid=gthhyujkio     salary=45424     tax=5255
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC9:Should not insert single record of working class hero with invalid birthday format in DD.MM.YYYY (POST)
    ${date}=    Convert To String   30.01.1993
    ${body}=    create dictionary    birthday=${date}    gender=m  name=john    natid=gthhyujkio     salary=25222     tax=2000
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC10:Should not insert single record of working class hero with invalid birthday format DMMYYYY (POST)
    ${date}=    Convert To String   1301993
    ${body}=    create dictionary    birthday=${date}    gender=m  name=john    natid=gthhyujkio     salary=25222     tax=2000
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC11:Should not insert single record of working class hero with invalid birthday format MMDDYYYY (POST)
    ${date}=    Convert To String   01301993
    ${body}=    create dictionary    birthday=${date}    gender=m  name=john    natid=gthhyujkio     salary=25222     tax=2000
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC12:Should not insert single record of working class hero with invalid birthday format DDMMMYYYY(POST)
    ${date}=    Convert To String   30Jan1993
    ${body}=    create dictionary    birthday=${date}    gender=m  name=john    natid=gthhyujkio     salary=25222     tax=2000
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=500
    log to console    ${response.status_code}
    log to console    ${response.content}

TC13:Should not insert single record of working class hero with future date of birth (POST)
    ${date}=    Convert To String   25022030
    ${body}=    create dictionary    birthday=${date}    gender=m  name=john    natid=gthhyujkio     salary=25222     tax=2000
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=400
    log to console    ${response.status_code}
    log to console    ${response.content}

TC14:Should not insert single record of working class hero with negative salary and/or tax (POST)
    ${body}=    create dictionary    birthday=25021993    gender=m  name=john    natid=gthhyujkio     salary=-22000     tax=-2000
    ${response}=    POST On Session    insertsession     /calculator/insert     json=${body}    headers=${header}   expected_status=400
    log to console    ${response.status_code}
    log to console    ${response.content}



