*** Settings ***
Documentation     Tests to verify the answer isn't submitted when selecting too few skills.
...               See: FEA21-skill-selection-view and TC-21-001, 
...                    FEA29-Softskill-selection-view and TC-29-001
Resource          ../resources/common.resource
Resource          ../resources/not_enough.resource
Library           Browser
Library           Collections
Library           DataDriver    file=../data/denydata.csv    encoding=UTF-8


Test Template     Not Enough Skills
Test Setup        Open Page In Browser    ${browser}    ${url}
Test Teardown     End Test

*** Variables ***
${url}        http://86.50.230.87/
${browser}    chromium

*** Test Cases ***
Not Enough Hard Skills    
    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${message}
Not Enough Soft Skills    
    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${message}
Not Enough Both Skills
    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${message}

*** Keywords ***
Not Enough Skills
    [Arguments]    ${hash}    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}    ${skills_soft}    ${message}
    Enter Hash    ${hash}
    Click Continue Button
    Select N Skills    ${skills_1}
    Select N Skills    ${skills_2}
    Select N Skills    ${skills_3}
    Select N Skills    ${skills_4}
    Click Continue Button
    Select N Skills    ${skills_soft}
    Click Continue Button
    Check Submit Alert    ${message}