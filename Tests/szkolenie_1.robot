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
        FOR    ${item1}    ${item2}    IN ZIP    ${LIST_VAR}    ${LIST_INT_VAR}
            Log    Iteracja: ${item1} - ${item2}
        END
    END

Zadanie - Dictionary Loop
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    Log    Robimy loop'a z dictem po key i val
    FOR    ${key}    ${value}    IN    &{DICT_VAR}
        Log    Iteracja ${key}: ${value}
    END

    Log    Robimy loop'a z dictem a item to tupla
    FOR    ${item}    IN    &{DICT_VAR}
        Log    Iteracja ${item}[0]: ${item}[1]
    END

Zadanie - IF Condition
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    IF    ${INT_VAR} > 40
        FOR    ${i}    IN RANGE    ${INT_VAR} + 5
            Log    Iteracja ${i}
        END
        Log    Liczba jest większa niż 40
    ELSE IF    ${INT_VAR} == 40
        Log    Liczba jest równa 40
    ELSE
        Log    Liczba jest mniejsza niż 40
    END
    # tylko jeden keyword zostanie wykonany, jeśli warunek jest spełniony
    Run Keyword If    ${INT_VAR} < 40    Log    Liczba jest większa niż 40

    Run Keyword If    ${INT_VAR} > 40    Run Keywords    Log    Liczba jest większa niż 40
    ...    AND    Log    To jest dodatkowy log, który zostanie wykonany, jeśli warunek jest spełniony

Zadanie - WHILE Loop
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    ${counter}    Set Variable    0
    WHILE    ${counter} < 5
        ${status}    Run Keyword And Return Status    Log    Iteracja ${counter}
        Run Keyword If    not ${status}    Log    Wystąpił błąd podczas logowania iteracji ${counter}
        Run Keyword If    ${status}    Exit For Loop    # jeśli logowanie się powiodło, zakończ loop
        ${counter}    Set Variable    ${counter} + 1
        Sleep    1s
    END
    Wait Until Keyword Succeeds    3x    200ms    Log    Czekamy aż licznik osiągnie 5
    

*** Keywords ***
Example Keyword
    [Documentation]    To jest przykładowy keyword, który można wykorzystać w testach.
    Log    This is an example keyword.
