*** Settings ***
Documentation    Age wise boundary testing for tax relief calculation
Library     RequestsLibrary
Library     Collections
Test Setup  Create API Session
Test Teardown   Delete Test Data and Sessions

*** Variables ***
${base_url}     http://localhost:8080
&{header}   content-type=application/json

&{17_year_old_male}    birthday=29092006    gender=M  name=Will    natid=5vx67OoRHl     salary=25000     tax=5750
&{18_year_old_male}    birthday=20082004    gender=M  name=James    natid=CHBxTJcUs4     salary=36341     tax=8358.43
&{19_year_old_male}    birthday=09072003    gender=M  name=Samuel    natid=cijVFHIJu4     salary=45000     tax=10350.00
&{35_year_old_male}    birthday=10081987    gender=M  name=Richard    natid=Y5k6PcwBko     salary=21554     tax=4957.42
&{36_year_old_male}    birthday=11071986    gender=M  name=William    natid=qBsi4S85fL     salary=10546     tax=2425.58
&{50_year_old_male}    birthday=16081972    gender=M  name=Henry    natid=lGaOuNkKd9     salary=25000     tax=5750.00
&{51_year_old_male}    birthday=07081971    gender=M  name=Walter    natid=tdpSGPVUgM     salary=64031     tax=14727.13
&{75_year_old_male}    birthday=18091947    gender=M  name=Andrew    natid=_UoH_rMT_p     salary=30000     tax=6900.00
&{76_year_old_male}    birthday=21081946    gender=M  name=Ernest    natid=3JRUloCFrd     salary=28650     tax=6589.50
&{77_year_old_male}    birthday=01041945    gender=M  name=Tom    natid=f8Pu9J92hh     salary=24573     tax=5651.79

&{18_year_old_female}    birthday=25062004    gender=F  name=Chloe    natid=uPDYa2a_Ec     salary=98492     tax=22653.16
&{19_year_old_female}    birthday=11072003    gender=F  name=Emma    natid=Nqw8qOJMIG     salary=64992     tax=14948.16
&{35_year_old_female}    birthday=08021987    gender=F  name=Alice    natid=_p2Ujcj8Fx     salary=54934     tax=12634.82
&{36_year_old_female}    birthday=22041986    gender=F  name=Luna    natid=lrj0erdU4P     salary=35834     tax=8241.82
&{50_year_old_female}    birthday=11051972    gender=F  name=Lily    natid=MrBY8m99SX     salary=17324     tax=3984.52
&{51_year_old_female}    birthday=13061971    gender=F  name=Ella    natid=9fYN0YEGdV     salary=30000     tax=6900.00
&{75_year_old_female}    birthday=27011947    gender=F  name=Anna    natid=TCUtaRAp5y     salary=83886     tax=19293.78
&{76_year_old_female}    birthday=17071946    gender=F  name=Lucy    natid=zeDBHQQ1-Z     salary=51762     tax=11905.26
&{77_year_old_female}    birthday=02021945    gender=F  name=Aria    natid=yqGYL6ABk0     salary=54205     tax=12467.15


${expected_tax_relief_for_17_age_male}  19250.00
${expected_tax_relief_for_18_age_male}  27982.60
${expected_tax_relief_for_19_age_male}  27720.00
${expected_tax_relief_for_35_age_male}  13277.30
${expected_tax_relief_for_36_age_male}  4060.20
${expected_tax_relief_for_50_age_male}  9625.00
${expected_tax_relief_for_51_age_male}  18094.50
${expected_tax_relief_for_75_age_male}  8477.70
${expected_tax_relief_for_76_age_male}  1103.00
${expected_tax_relief_for_77_age_male}  1446.10
${expected_tax_relief_for_18_age_female}  76338.80
${expected_tax_relief_for_19_age_female}  40535.10
${expected_tax_relief_for_35_age_female}  34339.30
${expected_tax_relief_for_36_age_female}  14296.10
${expected_tax_relief_for_50_age_female}  7169.70
${expected_tax_relief_for_51_age_female}  8977.70
${expected_tax_relief_for_75_age_female}  24205.30
${expected_tax_relief_for_76_age_female}  2492.80
${expected_tax_relief_for_77_age_female}  2586.90

*** Keywords ***
Create API Session
    create session    insertsession   ${base_url}

Delete Test Data and Sessions
    POST On Session   insertsession   /calculator/rakeDatabase
    Delete All Sessions

Given Clerk inserted employee data in system
    [Arguments]     ${request_body}
    Log     ${request_body}
    POST On Session    insertsession     /calculator/insert     json=${request_body}    headers=${header}   expected_status=202

When Bookkeeper retirves payable taxasion relief
    ${response}=    GET On Session      insertsession   /calculator/taxRelief   expected_status=200
    ${response_data}=     Set Variable    ${response.json()}
    ${actual_emp1_dict}=   Set Variable    ${response_data[0]}
    ${actual_emp_tax_relief}=   Get From Dictionary     ${actual_emp1_dict}     relief
    [return]    ${actual_emp_tax_relief}

Then payable taxasion releif should be computed as per fomula
    [Arguments]     ${actual_tax_relief}    ${expected_tax_relief}
    Should be equal     ${actual_tax_relief}    ${expected_tax_relief}


*** Test Cases ***
TC1:Male Emplyee of 18 year old
    Given Clerk inserted employee data in system    ${18_year_old_male}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_18_age_male}

TC2:Male Emplyee of more than 18 year old
    Given Clerk inserted employee data in system    ${19_year_old_male}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_19_age_male}

TC3:Male Emplyee of 35 year old
    Given Clerk inserted employee data in system    ${35_year_old_male}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_35_age_male}

TC4:Male Emplyee of more than 35 year old
    Given Clerk inserted employee data in system    ${36_year_old_male}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_36_age_male}

TC5:Male Emplyee of 50 year old
    Given Clerk inserted employee data in system    ${50_year_old_male}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_50_age_male}

TC6:Male Emplyee of more than 50 year old
    Given Clerk inserted employee data in system    ${51_year_old_male}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_51_age_male}

TC7:Male Emplyee of 75 year old
    Given Clerk inserted employee data in system    ${75_year_old_male}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_75_age_male}

TC8:Male Emplyee of 76 year old
    Given Clerk inserted employee data in system    ${76_year_old_male}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_76_age_male}

TC9:Male Emplyee of 77 year old
    Given Clerk inserted employee data in system    ${77_year_old_male}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_77_age_male}

#FOR FEMALES
TC10:Female Emplyee of 18 year old
    Given Clerk inserted employee data in system    ${18_year_old_female}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_18_age_female}

TC11:Female Emplyee of more than 18 year old
    Given Clerk inserted employee data in system    ${19_year_old_female}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_19_age_female}

TC12:Female Emplyee of 35 year old
    Given Clerk inserted employee data in system    ${35_year_old_female}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_35_age_female}

TC13:Female Emplyee of more than 35 year old
    Given Clerk inserted employee data in system    ${36_year_old_female}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_36_age_female}

TC14:Female Emplyee of 50 year old
    Given Clerk inserted employee data in system    ${50_year_old_female}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_50_age_female}

TC15:Female Emplyee of more than 50 year old
    Given Clerk inserted employee data in system    ${51_year_old_female}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_51_age_female}

TC16:Female Emplyee of 75 year old
    Given Clerk inserted employee data in system    ${75_year_old_female}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_75_age_female}

TC17:Female Emplyee of 76 year old
    Given Clerk inserted employee data in system    ${76_year_old_female}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_76_age_female}

TC18:Female Emplyee of 77 year old
    Given Clerk inserted employee data in system    ${77_year_old_female}
    ${tax_relief}=  When Bookkeeper retirves payable taxasion relief
    Then payable taxasion releif should be computed as per fomula   ${tax_relief}   ${expected_tax_relief_for_77_age_female}

