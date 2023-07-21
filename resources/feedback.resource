*** Settings ***
Documentation    Keywords for Feedback test suite.
Library          Browser
Library          Collections

*** Keywords ***
Check Feedback Button
    Get Element    \#doorbell-button
    Get Text    \#doorbell-button    ==    Feedback

Check Feedback Form
    Click    \#doorbell-button
    Get Text    \#doorbell-title    ==    Feedback
    Type Text    \#doorbell-feedback    O-ver-flow forever let's go!
    Clear Text    \#doorbell-feedback
    Click    \#doorbell-form > fieldset > div.buttons
    Click    \#doorbell-close