*** Settings ***
Documentation     Szkolenie 1 - Podstawy Robot Framework
Resource          Resources${/}Functional_keywords${/}fk_handler.resource

Test Tags       leonid

*** Variables ***
${STR_VAR}    Hello, Robot Framework!
${INT_VAR}    ${42}
${FLOAT_VAR}    ${3.14}
@{LIST_VAR}    Item 1    Item 2    Item 3    Item 4
@{LIST_INT_VAR}    ${12}    ${19}    ${25}
&{DICT_VAR}    key1=value1    key2=value2    key3=value3


*** Test Cases ***
Zadanie - Loop
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    [Tags]    leonid
    Log    Robimy loop'a
    fk_leonid.Keyword Loop Examples    ${LIST_VAR}    ${INT_VAR}    ${LIST_INT_VAR}
