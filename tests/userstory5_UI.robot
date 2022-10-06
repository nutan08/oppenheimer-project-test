*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library     RequestsLibrary
Suite Setup     Create Chrome Driver And Open Url
Suite Teardown     Clean Up Data And Close Browser

*** Variables ***
${url}      http://localhost:8080/
${browser}      chrome
${expected_button_color}    rgba(220, 53, 69, 1)

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
TC1:Dispense now button on screen should be red colored (GET)
    ${element}=     Get Webelement      css=body:nth-child(2) div.container-fluid:nth-child(1) div.container:nth-child(4) div:nth-child(1) > a.btn.btn-danger.btn-block:nth-child(8)
    ${bg_color}=    Call Method     ${element}      value_of_css_property   background-color
    log     ${bg_color}
    Should be equal     ${bg_color}     ${expected_button_color}

TC2:Text on the button
    ${element}=     Get Webelement      css=body:nth-child(2) div.container-fluid:nth-child(1) div.container:nth-child(4) div:nth-child(1) > a.btn.btn-danger.btn-block:nth-child(8)
    ${text}=    Get text    ${element}
    log     ${text}
    Should be equal     ${text}     Dispense Now

TC3:Should redirect when click on Dispense Now button
    ${element}=     Get Webelement      css=body:nth-child(2) div.container-fluid:nth-child(1) div.container:nth-child(4) div:nth-child(1) > a.btn.btn-danger.btn-block:nth-child(8)
    Click Link      ${element}
    Sleep   5
    ${directed_page_element}=   Get Webelement      css=div.v-application.v-application--is-ltr.theme--light div.v-application--wrap main.v-main.v-content div.v-main__wrap.v-content__wrap div.container > div.display-4.font-weight-bold
    ${text}=    Get text    ${directed_page_element}
    log     ${text}
    Should be equal     ${text}     Cash dispensed


