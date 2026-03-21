*** Settings ***
Documentation     Szkolenie 1 - Podstawy Robot Framework

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
    Log    Robimy loop'a
    FOR    ${i}    IN    @{LIST_VAR}
        Log    Iteracja ${i}
    END
    FOR    ${i}    IN    Artur   Marcin    Piotr    ${12}    ${19}    ${25}
        Log    Iteracja ${i}
    END    
    FOR    ${i}    IN RANGE    0    5
        Log    Iteracja ${i}
    END
    FOR    ${i}    IN RANGE    ${INT_VAR} + 5
        Log    Iteracja ${i}
    END
    FOR    ${index}    ${value}    IN ENUMERATE    @{LIST_VAR}
        Log    Iteracja ${index}: ${value}
    END
    FOR    ${item1}    ${item2}    IN ZIP    ${LIST_VAR}    ${LIST_INT_VAR}
        Log    Iteracja: ${item1} - ${item2}
    END

*** Keywords ***
Example Keyword
    [Documentation]    To jest przykładowy keyword, który można wykorzystać w testach.
    Log    This is an example keyword.
