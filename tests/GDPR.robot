*** Settings ***
Documentation     Tests to verify GDPR can be accessed.
...               See: FEA04-GDPR-Info and TC-04-001
Resource          ../resources/common.resource
Library           Browser
Library           Collections

Test Setup       Open Page In Browser    ${browser}    ${url}
Test Teardown    End Test

*** Variables ***
${url}        http://86.50.230.87/
${browser}    chromium

*** Variables ***
@{gdpr_en}    GDPR Statement    Close
@{gdpr_fi}    GDPR-seloste    Sulje
@{gdpr_swe}   GDPR-avslöjande   Stäng

*** Test Cases ***

Check GDPR Home Page
    [Tags]    Functional    FEA04
    Check GDPR Statement    ${gdpr_en}
    Change Language         fi
    Check GDPR Statement    ${gdpr_fi}
    Change Language         swe
    Check GDPR Statement    ${gdpr_swe}
