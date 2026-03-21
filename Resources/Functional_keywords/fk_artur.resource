*** Settings ***
Library    BuiltIn
Library    Collections

*** Variables ***
${KEYWORD_1}    Example Keyword
${KEYWORD_2}    Another Keyword

*** Keywords ***
Keyword Loop Examples
    [Documentation]    Mandatory Arguments
    [Arguments]    ${LIST_VAR}    ${INT_VAR}    ${LIST_INT_VAR}
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

Keyword Dict And Positional And Named Arguments  
    [Documentation]    Mandatory Arguments + Default Arguments
    [Arguments]    ${DICT_VAR}    ${name}=Default Name
    Log    Rbimy loop'a z dictem po key i val
    FOR    ${key}    ${value}    IN    &{DICT_VAR}
        Log    Iteracja ${key}: ${value}
    END

    Log    Robimy loop'a z dictem a item to tupla
    FOR    ${item}    IN    &{DICT_VAR}
        Log    Iteracja ${item}[0]: ${item}[1]
    END
    Log    Imię: ${name}

Optional Arguments: List
    [Documentation]    Przypadki użycia  Optional Arguments z listą
    [Arguments]    @{args}    ${name}=Default Name
    FOR   ${arg}    IN    @{args}
        Log    Iteracja ${arg}
    END
    Log    Lista argumentów: ${args}
    Log    Imię: ${name}

Optional Arguments: Dictionary
    [Documentation]    Przypadki użycia  Optional Arguments z dictionary
    [Arguments]    ${name}=Default Name    &{kwargs}
    FOR   ${key}    ${value}    IN    &{kwargs}
        Log    Iteracja ${key}: ${value}
    END
    Log    Słownik argumentów: ${kwargs}
    Log    Imię: ${name}

Optional Arguments: List & Dict
    [Documentation]    Przypadki użycia  Optional Arguments z listą i dictionary
    [Arguments]    ${name}=Default Name    @{args}    &{kwargs}
    FOR   ${arg}    IN    @{args}
        Log    Iteracja ${arg}
    END
    FOR   ${key}    ${value}    IN    &{kwargs}
        Log    Iteracja ${key}: ${value}
    END
    Log    Lista argumentów: ${args}
    Log    Słownik argumentów: ${kwargs}
    Log    Imię: ${name}
  
*** Comments ***
This is a comment in the resource file.

 positional argument, a zmienna "name" to named argument