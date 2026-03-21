*** Settings ***
Resource          lib_handler.resource

*** Variables ***
${KEYWORD_1}    Example Keyword
${KEYWORD_2}    Another Keyword

*** Keywords ***
Keyword Loop Examples
    [Documentation]    Przykłady różnych rodzajów loopów w Robot Framework.
    ...   LIST_VAR = to lista stringów
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

*** Comments ***
This is a comment in the resource file.