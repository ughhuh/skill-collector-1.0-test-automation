*** Settings ***
Documentation     Tests to verify tooltip is displayed on hover with correct information.
...               See: FEA20-skill-info-view and TC-20-001
Resource          ../resources/common.resource
Library           Browser
Library           Collections
Library           String
Library           DataDriver    file=../data/hoverdata.csv    encoding=UTF-8


Test Template     Hover Tooltip
Test Setup        Open Page In Browser    ${browser}    ${url}
Test Teardown     End Test

*** Variables ***
${url}        http://86.50.230.87/
${browser}    chromium

*** Test Cases ***
Hover Hard Skills
    ${hash}    ${setup}    ${skills_id}    ${skills_name}    ${skills_desc}

Hover Soft Skills
    ${hash}    ${setup}    ${skills_id}    ${skills_name}    ${skills_desc}

*** Keywords **
Hover Tooltip
    [Arguments]    ${hash}    ${setup}    ${skills_id}    ${skills_name}    ${skills_desc}
    Run Keyword    ${setup}    ${hash}
    ${hover_count}=    Get Length    ${skills_id}
    
    FOR    ${index}    IN RANGE   ${hover_count}
        Get Element States    css=\#${skills_id}[${index}] > td.skill-container > i > span    validate    hidden
        Hover    css=\#${skills_id}[${index}] > td.skill-container > div.tooltip-icon > i
        Get Element States    css=\#${skills_id}[${index}] > td.skill-container > div.tooltip-icon > div    validate    visible
        ${text}    Get Text    css=\#${skills_id}[${index}] > td.skill-container > div.tooltip-icon > div
        Compare Strings    ${skills_desc}[${index}]    ${text}
        ${text}    Get Text    css=\#${skills_id}[${index}] > td.skill-container > div.skill-name
        Compare Strings    ${skills_name}[${index}]    ${text}
    END

Compare Strings
    [Arguments]    ${expected_text}    ${actual_text}

    ${expected_text}    Replace String    ${expected_text}    xa0    ${SPACE}
    ${actual_text}    Replace String    ${actual_text}    xa0    ${SPACE}
    
    Should Be Equal As Strings    ${expected_text}    ${actual_text}    strip_spaces=True    collapse_spaces=True 
