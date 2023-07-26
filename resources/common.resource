*** Settings ***
Documentation    General keywords for test suites.
Resource         feedback.resource
Library          Browser
Library          Collections
Library          String

*** Keywords ***
### Browser Setups ###
Open Page In Browser
    [Arguments]    ${browser}    ${url}
    New Browser    ${browser}    True
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page    ${url}
### END ###

### Skill Page Setups ###
Access Hard Skills
    [Arguments]    ${hash}
    Enter Hash    ${hash}
    Click Continue Button

Access Soft Skills
    [Arguments]    ${hash}
    Enter Hash    ${hash}
    Click Continue Button
    Click Continue Button
### END ###

### Teardowns ###
End Test
    Delete All Cookies
    Close Page
    Close Context
    Close Browser
### END ###

### Navigation ###
Enter Hash
    [Arguments]    ${hash}
    Click    id=hash-lookup
    Type Text    id=hash-lookup    ${hash}
    Click    	button.start-button
    Wait For Elements State    button.start-button    detached

Click Continue Button
    Click    button.continue-btn
    Wait Until Network Is Idle

Submit Answers
    Click    button.right
    Wait Until Network Is Idle
### END ###

### Progress Bar ###
Check Progress Bar Count    # checks that the expected number of progress bars is highlighted
    [Arguments]    ${expected_count}
    ${real_count}=    Get Element Count    div.progress
    Should Be Equal As Numbers    ${expected_count}    ${real_count}

Check Progress Bar Count In Category    # type={1:soft, 2:hard}. hard/cat={1:fut, 2:val, 3:imp, 4: mipm}. soft/cat={1:val, 2:imp, 3:mimp}
    [Arguments]    ${type}    ${category}    ${expected_count}
    ${real_count}=    Get Element Count    div.progressbar:nth-child(${type}) > div:nth-child(${category}) > div > div > div.progress
    Should Be Equal As Numbers    ${expected_count}    ${real_count}
### END ###

### GDPR ###
Check GDPR Statement
    [Arguments]    ${language}
    Click    xpath=//a[@class='gdpr-link']
    Get Text    \#app > div.container > div.modal > div > div > header > h1    ==    ${language}[0]
    Scroll To    button.close-btn
    Get Text    button.close-btn    ==    ${language}[1]
    Click    button.close-btn
### END ###

### Page Settings ###
Change Language
    [Arguments]    ${language_option}
    ${lang} =	Convert To Upper Case	${language_option}
    Click    div.dropdown
    Click    xpath=//a[text()='${lang}']
    Wait Until Network Is Idle
### END ###

### Skill Selection ###
Select N Skills
    [Arguments]    ${skills}

    FOR    ${skill}    IN    @{skills}
        Click    input#${skill}
    END

Select 20 Hard Skills
    [Arguments]    ${skills_1}    ${skills_2}    ${skills_3}    ${skills_4}
    ${init_count}=    Get Element Count    div.progress

    FOR    ${index}    IN RANGE   5
        Click    input#${skills_1}[${index}]
        Click    input#${skills_2}[${index}]
        Click    input#${skills_3}[${index}]
        Click    input#${skills_4}[${index}]
        ${bar_count}=    Evaluate    (${index}+1)*4+${init_count}
        Check Progress Bar Count    ${bar_count}
    END

    Check Progress Bar Count    20

Select 3 Soft Skills
    [Arguments]    ${skills_soft}
    ${init_count}=    Get Element Count    div.progress

    FOR    ${index}    IN RANGE   3
        Click    input#${skills_soft}[${index}]
        ${bar_count}=    Evaluate    ${index}+${init_count}+1
        Check Progress Bar Count    ${bar_count}
    END 

    Check Progress Bar Count    23
### END ###
