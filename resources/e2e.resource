*** Settings ***
Documentation    Keywords for End-To-End test suite.
Resource         feedback.resource
Library          Browser
Library          Collections

*** Keywords ***
Confirm Selection
    [Arguments]    ${skill_titles}
    
    ${selections}    Evaluate JavaScript    ul > li > ul > li    (elem) => elem.map(item => item.textContent.trim().split(':')[0])    all_elements=True
    
    FOR    ${item}    IN    @{skill_titles}
        Should Contain    ${selections}    ${item}
    END

Confirm Submission
    [Arguments]    ${hash}    ${text}

    Wait For Condition    Url    should end with    ${hash}/success
    Check Feedback Form
    Get Text    div.thankyou-content > h1    ==    ${text}
    Click    div.thankyou-content > button
    Wait For Condition    Url    should end with    ${EMPTY}