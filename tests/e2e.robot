*** Settings ***
Documentation     Tests to verify basic user workflow in different languages.
...               See: Use Case # 2
Resource          ../resources/common.resource
Resource          ../resources/e2e.resource
Library           Browser
Library           Collections
Library           DataDriver    file=../data/e2edata.csv    encoding=UTF-8

Test Template     E2E
Test Setup        Open Page In Browser    ${browser}    ${url}
Test Teardown     End Test

*** Variables ***
${url}        http://86.50.230.87/
${browser}    chromium

*** Test Cases ***
E2E ENG
    ${language}    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${skill_titles}    ${text}
E2E FI
    ${language}    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${skill_titles}    ${text}
E2E SWE
    ${language}    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${skill_titles}    ${text}

*** Keywords ***
E2E
    [Arguments]    ${language}    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${skill_titles}    ${text}
    Change Language    ${language}
    Enter Hash    ${hash}
    Click Continue Button
    Select 20 Hard Skills    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}
    Click Continue Button
    Select 3 Soft Skills    ${skills_soft}
    Click Continue Button
    Confirm Selection    ${skill_titles}
    Submit Answers
    Confirm Submission    ${hash}    ${text}