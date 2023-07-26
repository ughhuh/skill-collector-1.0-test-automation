*** Settings ***
Documentation    Keywords for Skill Selection Alert test suite.
Library          Browser
Library          Collections

*** Keywords ***
Check Alert
    [Arguments]    ${category}    ${number}
    Wait For Elements State    div.swal2-popup.swal2-modal.swal2-show    visible
    Get Text    id=swal2-html-container    contains    ${category}
    Get Text    id=swal2-html-container    contains    ${number}
    Get Text    button.swal2-confirm.my-confirm-button-class    ==    Got it
    Click    button.swal2-confirm.my-confirm-button-class 
    Get Element States    div.swal2-popup.swal2-modal.swal2-show    contains    detached