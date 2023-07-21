*** Settings ***
Documentation     Tests to verify skill selection persistence.
...               See: FEA21-skill-selection-view and TC-21-001
Resource          ../resources/common.resource
Resource          ../resources/backtrack.resource
Library           Browser
Library           Collections
Library           DataDriver    file=../data/e2edata.csv    encoding=UTF-8

Test Template     Backward Tracking
Test Setup        Open Page In Browser    ${browser}    ${url}
Test Teardown     End Test

*** Variables ***
${url}        http://86.50.230.87/
${browser}    chromium

*** Test Cases ***
E2E ENG
    ${language}    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${skill_titles}

*** Keywords ***
Backward Tracking
    [Arguments]    ${language}    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${skill_titles}
    Change Language    ${language}
    Enter Hash    ${hash}
    Click Continue Button
    Select 20 Hard Skills    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}
    Click Continue Button
    Select 3 Soft Skills    ${skills_soft}
    Backtrack    ${hash}
    Enter Hash    ${hash}
    Click Continue Button
    Check Hard Skills Selection    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}
    Click Continue Button
    Check Soft Skills Selection    ${skills_soft}

Check Hard Skills Selection
    [Arguments]    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}
    Wait For Elements State    div.SkillSidebar    visible
    Check Progress Bar Count    23
    ${hard_skill_list}    Combine Lists    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4} 
    Check Radio Button Selection     ${hard_skill_list} 

Check Soft Skills Selection
    [Arguments]    ${skills_soft}
    Wait For Elements State    div.SkillSidebar    visible
    Check Progress Bar Count    23
    Wait Until Network Is Idle
    Check Radio Button Selection     ${skills_soft}