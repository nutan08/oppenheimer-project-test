*** Settings ***
Documentation    Test get tax relief and get tax relief summary API
Library     RequestsLibrary
Library     Collections
Test Setup  Create Session And Insert Test Data
Test Teardown   Delete Test Data and Sessions

*** Variables ***
${base_url}     http://localhost:8080
${expected_length_of_records}   4
${expected_netid_emp1}   hyju$$$$$$
${expected_netid_emp2}   gthh$$$$$$
${expected_min_tax_relief}   50.00
${expected_rounded_up_tax_relief}   1809.70
${expected_rounded_down_tax_relief}     34339.30

*** Keywords ***
Create Session And Insert Test Data
    create session    insertsession   ${base_url}
    ${emp1}=    create dictionary    birthday=02021956    gender=f  name=minny    natid=hyjukitrfe     salary=50000     tax=880
    ${emp2}=    create dictionary    birthday=25021993    gender=m  name=jin    natid=gthhyujkio     salary=50     tax=11.5
    ${emp3}=    create dictionary    birthday=25031957    gender=m  name=Ross    natid=hyjukithyu     salary=5701     tax=770
    ${emp4}=    create dictionary    birthday=25031987    gender=f  name=Monica    natid=abjuthyhyu     salary=54934     tax=12634.82
    ${body}=    create list     ${emp1}     ${emp2}     ${emp3}     ${emp4}
    ${header}=   create dictionary    Content-Type=application/json
    POST On Session    insertsession     /calculator/insertMultiple     json=${body}    headers=${header}   expected_status=202

Delete Test Data and Sessions
    POST On Session   insertsession   /calculator/rakeDatabase
    Delete All Sessions

Get All Employee Tax Relief Data
    ${response}=    GET On Session      insertsession   /calculator/taxRelief   expected_status=200
    log to console  ${response.json()}
    [return]    ${response.json()}

*** Test Cases ***
TC1:All employee tax reliefs data should be as expected (GET)
    ${response_data}=   Get All Employee Tax Relief Data
    ${length}=  Get Length  ${response_data}
    log to console  ${length}
    Should be equal as numbers  ${length}   ${expected_length_of_records}

TC2:Get tax relief endpoint should return natid, tax relief amount and name (GET)
    @{response_data}=   Get All Employee Tax Relief Data
    FOR     ${item}     IN  @{response_data}
        Dictionary should contain key   ${item}     name
        Dictionary should contain key   ${item}     natid
        Dictionary should contain key   ${item}     relief
    END

TC3:Natid field should be masked from 5th chracter onwards with $ sign(GET)
    ${response_data}=   Get All Employee Tax Relief Data
    ${actual_emp1_dict}=   Set Variable    ${response_data[0]}
    ${actual_emp1_natid}=   Get From Dictionary     ${actual_emp1_dict}     natid
    Should be equal  ${actual_emp1_natid}   ${expected_netid_emp1}

TC4:Final minimum tax relief amount should be 50.00 (GET)
    ${response_data}=   Get All Employee Tax Relief Data
    ${actual_emp2_dict}=    Set Variable    ${response_data[1]}
    ${actual_emp2_tax_relief}=   Get From Dictionary     ${actual_emp2_dict}     relief
    Should be equal     ${actual_emp2_tax_relief}    ${expected_min_tax_relief}

TC5:Calculated tax relief amount should be rounded up (GET)
    ${response_data}=   Get All Employee Tax Relief Data
    ${actual_emp3_dict}=     Set Variable    ${response_data[2]}
    ${actual_emp3_tax_relief}=   Get From Dictionary     ${actual_emp3_dict}      relief
    Should be equal     ${actual_emp3_tax_relief}    ${expected_rounded_up_tax_relief}

TC6:Calculated tax relief amount should be rounded down (GET)
    ${response_data}=   Get All Employee Tax Relief Data
    ${actual_emp4_dict}=     Set Variable    ${response_data[3]}
    ${actual_emp4_tax_relief}=   Get From Dictionary     ${actual_emp4_dict}      relief
    Should be equal     ${actual_emp4_tax_relief}    ${expected_rounded_down_tax_relief}

