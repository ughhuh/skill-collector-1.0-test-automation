*** Settings ***
Documentation     Tests to verify that the user can navigate between hard skill categories.
...               See: FEA-32-navigation-bar and TC-32-001
Resource          ../resources/common.resource
Library           Browser
Library           String
Library           Collections

Test Setup       Open Page In Browser    ${browser}    ${url}
Test Teardown    End Test

*** Variables ***
${url}        http://86.50.230.87/
${browser}    chromium

*** Test Cases ***
Click Navigation Headers
    [Tags]    Functional    Regression    FEA32
    Access Hard Skills

    ${headers}=   Get Elements    div.navbar > a 

    FOR    ${header}    IN    @{headers}
        Click    ${header}
        Wait For Condition    Classes    ${header}    contains    active
        Get Style    ${header}    background-color    ==    rgb(71, 178, 255)
    END

Scroll The Page
    [Tags]    Functional    FEA03
    Access Hard Skills
    
    ${headers}   Get Elements    section > h2
    Remove From List    ${headers}    0
    
    FOR    ${header}    IN    @{headers}
        Scroll To Element    ${header}
        ${nav_header}    Get Element    div.navbar > a.active
        ${header_text}    Get Text    ${header}
        ${nav_text}    Get Text    ${nav_header}
        Should Be Equal As Strings    ${header_text}    ${nav_text}    ignore_case=True
        Get Style    ${nav_header}    background-color    ==    rgb(71, 178, 255)
    END
