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
Hard Skill Selection Alert
    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${categories}    ${number}    ${setup}

Soft Skill Selection Alert
    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${categories}    ${number}    ${setup}

*** Keywords ***
Skill Selection Alert
    [Arguments]    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${categories}    ${number}    ${setup}
    Run Keyword    ${setup}    ${hash}
    
    ${column_count}=    Get Length    ${skills_4}
    ${type} =	Set Variable If    ${column_count} == 0    1	2    # type={1:soft, 2:hard}

    Select N Skills    ${skills_1}
    Check Alert    ${categories}[0]    ${number}
    Select N Skills    ${skills_2}
    Check Alert    ${categories}[1]    ${number}
    Select N Skills    ${skills_3}
    Check Alert    ${categories}[2]    ${number}
    
    # Check 4th category in hard skill selection only
    Run Keyword If    ${type} == 2    Select N Skills    ${skills_4}
    Run Keyword If    ${type} == 2    Check Alert    ${categories}[3]    ${number}
