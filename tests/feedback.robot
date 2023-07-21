*** Settings ***
Documentation     Tests to verify Feedback can be accessed.
...               See: FEA03-Customer-Feedback-system and TC-03-001
Library           Browser
Library           Collections
Resource          ../resources/common.resource
Resource          ../resources/feedback.resource

Test Setup        Open Page In Browser    ${browser}    ${url}
Test Teardown     End Test

*** Variables ***
${url}        http://86.50.230.87/
${browser}    chromium

*** Variables ***
${hash}    0123456789  

*** Test Cases ***
Check Feedback Home Page
    [Tags]    Functional    FEA03
    Check Feedback Button
    Check Feedback Form

Check Feedback Intro Page
    [Tags]    Functional    FEA03
    Enter Hash    ${hash}
    Check Feedback Button
    Check Feedback Form

Check Feedback Skill Selection 1
    [Tags]    Functional    FEA03
    Enter Hash    ${hash}
    Click Continue Button
    Check Feedback Button
    Check Feedback Form

Check Feedback Skill Selection 2
    [Tags]    Functional    FEA03
    Enter Hash    ${hash}
    Click Continue Button
    Click Continue Button
    Check Feedback Button
    Check Feedback Form