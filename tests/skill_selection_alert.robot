*** Settings ***
Documentation     Test to verify that selecting too many skills isn't possible.
...               See: FEA21-skill-selection-view and TC-21-001, 
...                    FEA29-Softskill-selection-view and TC-29-001
Resource          ../resources/common.resource
Resource          ../resources/alert.resource
Library           Browser
Library           Collections
Library           DataDriver    file=../data/alertdata.csv    encoding=UTF-8

Test Template     Skill Selection Alert
Test Setup        Open Page In Browser    ${browser}    ${url}
Test Teardown     End Test

*** Variables ***
${url}        http://86.50.230.87/
${browser}    chromium

*** Test Cases ***
Skill Selection Alert
    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}

*** Keywords ***
Skill Selection Alert
    [Arguments]    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}
    Enter Hash    ${hash}
    Click Continue Button
    Select Hard Skills    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}
    Click Continue Button
    Select Soft Skills    ${skills_soft}

Select Hard Skills
    [Arguments]    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}
    Select N+1 Skills    ${skills_1}
    Select N+1 Skills    ${skills_2}
    Select N+1 Skills    ${skills_3}
    Select N+1 Skills    ${skills_4}

Select Soft Skills
    [Arguments]    ${skills_soft}
    ${soft_1}    Get Slice From List    ${skills_soft}    0    2
    ${soft_2}    Get Slice From List    ${skills_soft}    2    4
    ${soft_3}    Get Slice From List    ${skills_soft}    4    6
    Select N+1 Skills    ${soft_1}
    Select N+1 Skills    ${soft_2}
    Select N+1 Skills    ${soft_3}