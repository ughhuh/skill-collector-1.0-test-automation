*** Settings ***
Documentation    Keywords for Backtracking test suite.
Library          Browser
Library          Collections

*** Keywords ***
Click Back Button
    [Arguments]    ${url}

    Click    button.back-btn
    Wait For Condition    Url    should end with    ${url}

Backtrack
    [Arguments]    ${hash}
    Click Back Button    ${hash}/form
    Click Back Button    ${hash}
    Click Back Button    ${EMPTY}

Check Radio Button Selection
    [Arguments]    ${elements}
    
    Wait For Elements State    div > main    visible
    
    FOR    ${element}    IN    @{elements}
        Wait For Elements State    input#${element}    visible
    END

    ${buttons_checked}    Get Elements    input[type="radio"]:checked
    ${len_1}    Get Length    ${buttons_checked}
    ${len_2}    Get Length    ${elements}
    Should Be Equal As Integers    ${len_1}    ${len_2}

    FOR    ${button}    IN    @{buttons_checked}
        ${button_id}    Get Property    ${button}    id
        Should Contain    ${elements}    ${button_id}
    END