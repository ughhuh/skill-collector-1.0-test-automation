*** Settings ***
Documentation    Keywords for Not Enough Skills Selected test suite.
Library          Browser
Library          Collections

*** Keywords ***

Check Submit Alert
    [Arguments]    ${error_message}
    Click    button.right
    Wait For Elements State    section > p.error-message    visible
    Get Text    section > p.error-message    ==    ${error_message}
    Click    button.left