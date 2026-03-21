*** Settings ***
Documentation     Szkolenie 1 - Podstawy Robot Framework
Resource          Resources${/}Functional_keywords${/}fk_handler.resource

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
        ${status}    Run Keyword And Return Status    Log    Iteracja ${counter}
        Run Keyword If    not ${status}    Log    Wystąpił błąd podczas logowania iteracji ${counter}
        Run Keyword If    ${status}    Exit For Loop    # jeśli logowanie się powiodło, zakończ loop
        ${counter}    Set Variable    ${counter} + 1
        Sleep    1s
    END
    Wait Until Keyword Succeeds    3x    200ms    Log    Czekamy aż licznik osiągnie 5
    
Zadanie - Try Except
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    TRY
        Log    To jest próba wykonania keyworda, który może się nie powieść.
        Fail    Celowo wywołujemy błąd, aby przetestować blok EXCEPT
    EXCEPT
        Log    Wystąpił błąd podczas wykonywania keyworda. Obsługujemy wyjątek.
        Fail    Test nie powiódł się z powodu błędu, ale został obsłużony w bloku EXCEPT.
   FINALLY
        Log    Ten blok zostanie wykonany niezależnie od tego, czy wystąpił błąd, czy nie.        
    END

Zadanie - SKIP
    [Documentation]    Napisz test, który otworzy stronę https://www.google.com,
    ...    wpisze w wyszukiwarkę "Robot Framework" i sprawdzi, czy na stronie wyników pojawi się tekst "robotframework.org".
    [Tags]    not_ready    DEFECT_NPS-1234
    Skip    Ten test jest pomijany, ponieważ nie jest jeszcze gotowy do uruchomienia.


Zadanie Optional Arguments: List
    [Documentation]    Przypadki użycia  Optional Arguments z listą
    [Tags]    optional_args
    fk_artur.Optional Arguments: List  # bardzo ryzkowna forma, bo przekazujemy pustą listę i defaultową wartość dla name - to może być zawsze zielony keyword
    fk_artur.Optional Arguments: List    Item 1    Item 2    Item 3    Item 4  # wszystkie argumenty trafia do @{args}, a name przyjmie wartość defaultową
    fk_artur.Optional Arguments: List    Item 1    Item 2    Item 3    Item 4    name=Artur  # wszystkie argumenty trafia do @{args}, a name przyjmie wartość z argumentu
    fk_artur.Optional Arguments: List    name=Artur  # przekazujemy tylko named argument, a lista jest pusta, a name przyjmuje wartość z argumentu, więc LOOP sięnie wykona
    fk_artur.Optional Arguments: List    ${LIST_VAR}  # wykona sie jeden loop bo cała ${LIST_VAR} trafi do args jako jeden argument, a name przyjmie wartość defaultową
    fk_artur.Optional Arguments: List    @{LIST_VAR}  # wykona sie 4 loop bo każdy element z ${LIST_VAR} trafi do args jako osobny argument, a name przyjmie wartość defaultową


*** Keywords ***
Example Keyword
    [Documentation]    To jest przykładowy keyword, który można wykorzystać w testach.
    Log    This is an example keyword.
