*** Settings ***
Documentation    Keywords for Skill Selection Alert test suite.
Library          Browser
Library          Collections

*** Keywords ***
Select N+1 Skills
    [Arguments]    ${skills}

    FOR    ${skill}    IN    @{skills}
        Click    input#${skill}
    END 

    Check Alert

Check Alert
    Wait For Elements State    div.swal2-container.swal2-center.swal2-backdrop-show    visible
    Get Text    id=swal2-title    ==    You can't select more than the allowed number of answers
    Get Text    button.swal2-confirm.my-confirm-button-class    ==    Got it
    Click    button.swal2-confirm.my-confirm-button-class
    Get Element States    id=swal2-html-container