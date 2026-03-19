*** Settings ***
Documentation    Simple Robot Framework test setup
Library          Collections
Library          String

*** Variables ***
${MESSAGE}       Hello, Robot Framework!
${NUMBER}        42

*** Test Cases ***
Simple Variable Test
    [Documentation]    Test basic variable usage
    Log    ${MESSAGE}
    Should Be Equal    ${MESSAGE}    Hello, Robot Framework!

Simple Math Test
    [Documentation]    Test basic mathematical operations
    ${result}=    Evaluate    10 + 5
    Should Be Equal As Numbers    ${result}    15
    Log    The result is: ${result}

String Operations Test
    [Documentation]    Test string manipulation
    ${upper_case}=    Convert To Upper Case    ${MESSAGE}
    Should Be Equal    ${upper_case}    HELLO, ROBOT FRAMEWORK!
    ${length}=    Get Length    ${MESSAGE}
    Should Be True    ${length} > 0

List Operations Test
    [Documentation]    Test list operations
    @{fruits}=    Create List    apple    banana    orange
    ${count}=    Get Length    ${fruits}
    Should Be Equal As Numbers    ${count}    3
    Should Contain    ${fruits}    banana

*** Keywords ***
Custom Greeting
    [Arguments]    ${name}
    [Documentation]    Custom keyword that returns a greeting
    ${greeting}=    Set Variable    Hello, ${name}!
    Log    ${greeting}
    RETURN    ${greeting}