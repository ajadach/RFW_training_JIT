*** Settings ***
Documentation     Szkolenie 1 - Podstawy Robot Framework
Resource          ../Resources${/}Generic_keywords${/}gk_handler.resource

Test Tags       artur

*** Variables ***
${STR_VAR}    Hello, Robot Framework!
${INT_VAR}    ${42}
${FLOAT_VAR}    ${3.14}
@{LIST_VAR}    Item 1    Item 2    Item 3    Item 4
@{LIST_INT_VAR}    ${12}    ${19}    ${25}
&{DICT_VAR}    key1=value1    key2=value2    key3=value3
${name_error}    zmienna_name_error



*** Test Cases ***
First Test Case
    [Documentation]    This is the first test case to demonstrate the creation test cases in Robot Framework.
    ...    DEPENDS_FROM_THE_PROJECT_WE_CAN_SHARE_LINK_TO_TEST_CASES_DESSIGN
    ...
    ...    *Steps / Expected*
    ...    - Simple log to Robot Framework report / pass
    ...
    ...    *Requirements*
    ...    - ITEM_NUMBER/NAME_FROM_REQUIREMENT_BOARD
    ...
    ...    *Expected*
    ...    - We would like to verify that we can create a simple test case in Robot Framework and log information to the report.
    Log    This is the first test case. We will log this information to the Robot Framework report.

Zadanie - Loop
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    [Tags]    artur
    Log    Robimy loop'a
    fk_artur.Keyword Loop Examples    ${LIST_VAR}    ${INT_VAR}    ${LIST_INT_VAR}

Zadanie - Dictionary Loop
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    [Tags]    pawel  
    # zmienna ${DICT_VAR} to positional argument, a zmienna "name" to named argument, więc kolejność ma znaczenie
    fk_artur.Keyword Dict And Positional And Named Arguments      ${DICT_VAR}    # poprawna forma
    fk_artur.Keyword Dict And Positional And Named Arguments      ${DICT_VAR}    Artur  # poprawna forma
    fk_artur.Keyword Dict And Positional And Named Arguments      ${DICT_VAR}    name=Artur  # poprawna forma
    Run Keyword And Expect Error    *    fk_artur.Keyword Dict And Positional And Named Arguments      ${DICT_VAR}    ${name}=Artur  # to się wywali, bo nie ma zmiennej ${name}
    fk_artur.Keyword Dict And Positional And Named Arguments      ${DICT_VAR}    ${name_error}=Artur  # to się nie wywali, ale zmienna name bedzie  ${name}='zmienna_name_error=Artur' w 14 linii
    Run Keyword And Expect Error    *    fk_artur.Keyword Dict And Positional And Named Arguments      name=Artur    ${DICT_VAR}  # nie poprawna forma -> "Keyword 'fk_artur.Keyword Dict And Positional And Named Arguments  ' got positional argument after named argument."

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
        ${status}    Run Keyword And Return Status    Log    iteration ${counter}
        Run Keyword If    not ${status}    Log    An error occurred while logging the iteration ${counter}
        Run Keyword If    ${status}    Exit For Loop    # if login was successful, exit loop
        ${counter}    Set Variable    ${counter} + 1
        Sleep    1s
    END
    Wait Until Keyword Succeeds    3x    200ms    Log    We exit at first pass
    
Zadanie - Try Except
    [Documentation]    The purpose of this test is to present the usage of TRY / EXCEPT / FINALLY blocks in Robot Framework, 
    ...    which allow us to handle exceptions and ensure that certain code is executed regardless of whether an error occurred or not.
    ...    DEPENDS_FROM_THE_PROJECT_WE_CAN_SHARE_LINK_TO_TEST_CASES_DESSIGN
    ...
    ...    *Steps / Expected*
    ...    - Execute TRY / fail
    ...    - Execute EXPECT / fail
    ...    - FINALLY / pass
    ...
    ...    *Requirements*
    ...    - ITEM_NUMBER/NAME_FROM_REQUIREMENT_BOARD
    ...
    ...    *Expected*
    ...    - We would like to verify that even if there is an error in TRY block, the test will not fail because we handle the exception in EXCEPT block, 
    ...    and FINALLY block will be executed regardless of the error.
    TRY
        Log    This is an attempt to execute keywords that may fail.
        Fail    We deliberately trigger an error to test the EXCEPT block
    EXCEPT
        Log    An error occurred while executing the keyword. We handle the exception.
        Fail    he test failed due to an error, but it was handled in the EXCEPT block.
   FINALLY
        Log    This block will be executed regardless of whether an error occurred or not.
    END

Zadanie - SKIP
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    [Tags]    not_ready    DEFECT_NPS-1234
    Skip    Ten test jest pomijany, ponieważ nie jest jeszcze gotowy do uruchomienia.


Zadanie Optional Arguments: List
    [Documentation]    Przypadki użycia  Optional Arguments z listą
    [Tags]    optional_args_list
    fk_artur.Optional Arguments: List  # bardzo ryzkowna forma, bo przekazujemy pustą listę i defaultową wartość dla name - to może być zawsze zielony keyword
    fk_artur.Optional Arguments: List    Item 1    Item 2    Item 3    Item 4  # wszystkie argumenty trafia do @{args}, a name przyjmie wartość defaultową
    fk_artur.Optional Arguments: List    Item 1    Item 2    Item 3    Item 4    name=Artur  # wszystkie argumenty trafia do @{args}, a name przyjmie wartość z argumentu
    fk_artur.Optional Arguments: List    Artur    Item 1    Item 2    Item 3    Item 4  # wszystkie argumenty trafia do @{args}, a name przyjmie wartość z argumentu
    fk_artur.Optional Arguments: List    name=Artur    # przekazujemy tylko named argument, a lista jest pusta, a name przyjmuje wartość z argumentu, więc LOOP sięnie wykona
    fk_artur.Optional Arguments: List    ${LIST_VAR}    # wykona sie jeden loop bo cała ${LIST_VAR} trafi do args jako jeden argument, a name przyjmie wartość defaultową
    fk_artur.Optional Arguments: List    @{LIST_VAR}    # wykona sie 4 loop bo każdy element z ${LIST_VAR} trafi do args jako osobny argument, a name przyjmie wartość defaultową
    Run Keyword And Expect Error    *    fk_artur.Optional Arguments: List    name=Artur    ${LIST_VAR}    # to się wywali, bo przekazujemy positional argument po named argument, a to jest niepoprawna forma

Zadanie Optional Arguments: Dict
    [Documentation]    Przypadki użycia  Optional Arguments z dictionary
    [Tags]    optional_args_dict
    fk_artur.Optional Arguments: Dictionary  # bardzo ryzkowna forma, bo przekazujemy pusty słownik i defaultową wartość dla name - to może być zawsze zielony keyword
    fk_artur.Optional Arguments: Dictionary    key1=value1    key2=value2    key3=value3  # wszystkie argumenty trafia do &{kwargs}, a name przyjmie wartość defaultową
    fk_artur.Optional Arguments: Dictionary    key1=value1    key2=value2    key3=value3    name=Artur  # wszystkie argumenty trafia do &{kwargs}, a name przyjmie wartość z argumentu
    fk_artur.Optional Arguments: Dictionary    name=Artur    # przekazujemy tylko named argument, a słownik jest pusty, a name przyjmuje wartość z argumentu
    fk_artur.Optional Arguments: Dictionary    name=Artur    key1=value1    key2=value2    key3=value3  # to się wywali, bo przekazujemy positional argument po named argument, a to jest niepoprawna forma

Zadanie Optional Arguments: List & Dict
    [Documentation]   Przypadki użycia  Optional Arguments z listą i dictionary
    [Tags]    optional_args_list_dict
    fk_artur.Optional Arguments: List & Dict  # bardzo ryzkowna forma, bo przekazujemy pustą listę i pusty słownik i defaultową wartość dla name - to może być zawsze zielony keyword
    fk_artur.Optional Arguments: List & Dict    Item 1    Item 2    Item 3    Item 4  # wszystkie argumenty trafia do @{args}, a name przyjmie wartość defaultową, a słownik będzie pusty
    fk_artur.Optional Arguments: List & Dict    key1=value1    key2=value2    key3=value3  # wszystkie argumenty trafia do &{kwargs}, a name przyjmie wartość defaultową, a lista będzie pusta
    fk_artur.Optional Arguments: List & Dict    Item 1    Item 2    Item 3    Item 4    key1=value1    key2=value2    key3=value3  # wszystkie argumenty trafia do @{args} i &{kwargs}, a name przyjmie wartość defaultową
    fk_artur.Optional Arguments: List & Dict    Item 1    Item 2    Item 3    Item 4    key1=value1    key2=value2    key3=value3    name=Artur  # wszystkie argumenty trafia do @{args} i &{kwargs}, a name się wywali bo Item 1 będzie już name więc mamy error: "Keyword 'fk_artur.Optional Arguments: List & Dict' got multiple values for argument 'name'."

Zadanie Embedded Arguments
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    [Tags]    embedded_args
    fk_artur.Example Keyword: Open Browser via Admin  # ten keyword ma embedded argument, więc nie musimy przekazywać żadnych argumentów, a on i tak wykona się poprawnie
    fk_artur.Example Keyword: Open Browser via User1  # ten keyword ma embedded argument, więc nie musimy przekazywać żadnych argumentów, a on i tak wykona się poprawnie
    fk_artur.Example Keyword: Open Browser via Admin with password    moje_haslo

*** Keywords ***
Example Keyword
    [Documentation]    To jest przykładowy keyword, który można wykorzystać w testach.
    Log    This is an example keyword.
