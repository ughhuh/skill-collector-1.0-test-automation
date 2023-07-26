*** Settings ***
Documentation     Tests to verify skill selection/deselection and progress bar update.
...               See: FEA21-skill-selection-view and TC-21-001, 
...                    FEA29-Softskill-selection-view and TC-29-001
Resource          ../resources/common.resource
Library           Browser
Library           Collections
Library           DataDriver    file=../data/cycledata.csv

Test Template     Cycle Skills
Test Setup        Open Page In Browser    ${browser}    ${url}
Test Teardown     End Test

*** Variables ***
${url}        http://86.50.230.87/
${browser}    chromium

*** Test Cases ***
Check Hard Skills
    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_btn}    ${setup}

Check Soft Skills
    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_btn}    ${setup}

*** Keywords ***
Cycle Skills
    [Arguments]    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_btn}    ${setup}
    Run Keyword    ${setup}    ${hash}
    
    ${button_count}=    Get Length    ${skills_1}
    ${column_count}=    Get Length    ${skills_4}
    ${type} =	Set Variable If    ${column_count} == 0    1	2    # type={1:soft, 2:hard}

    FOR    ${index}    IN RANGE   ${button_count}
        Click    input#${skills_1}[${index}]
        Check Progress Bar Count In Category    ${type}    1    1
        Click    button#${skills_btn}[${index}]
        Check Progress Bar Count In Category    ${type}    1    0

        Click    input#${skills_2}[${index}]
        Check Progress Bar Count In Category    ${type}    2    1
        Click    button#${skills_btn}[${index}]
                Check Progress Bar Count In Category    ${type}    2    0

        Click    input#${skills_3}[${index}]
        Check Progress Bar Count In Category    ${type}    3    1
        Click    button#${skills_btn}[${index}]
        Check Progress Bar Count In Category    ${type}    3    0
        
        Continue For Loop If    ${column_count} == 0    # don't check 4th column for soft skills

        Click    input#${skills_4}[${index}]
        Check Progress Bar Count In Category        ${type}    4    1    
        Click    button#${skills_btn}[${index}]
        Check Progress Bar Count In Category    ${type}    4    0
    END