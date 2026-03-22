*** Settings ***
Documentation     Resource for data generation keywords.
Resource          lib_handler.resource

*** Keywords ***
Pet: Create Pet - Generate Json
    [Documentation]    Keyword to create a pet JSON body for API testing.
    &{category}      Create Dictionary    id=1    name=Dogs
    @{photo_urls}    Create List          https://example.com/photo.jpg
    &{tag}           Create Dictionary    id=1    name=labrador
    @{tags}          Create List          ${tag}
    &{pet_body}      Create Dictionary
    ...    id=987654
    ...    name=Buddy
    ...    category=${category}
    ...    photoUrls=${photo_urls}
    ...    tags=${tags}
    ...    status=available
    RETURN    ${pet_body}
