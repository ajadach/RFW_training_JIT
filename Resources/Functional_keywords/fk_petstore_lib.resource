*** Settings ***
Documentation     Keywords related to Petstore API testing.
Resource          lib_handler.resource


*** Keywords ***
LIB Open Session
    [Documentation]    Keyword to open a session with the Petstore API.
    petstore_lib.LIB Open Session    ${ENV_VAR.url_petstore}

LIB Pet: Create Pet
    [Documentation]    Create a new pet with given details and return the response. We add "Pet: " prefix to the keyword name to indicate that it's related to pet operations.
    ...    *Arguments*
    ...    | =Name= | =Description= | =Example value= |
    ...    | pet_body | JSON object representing the pet to be created | {"id": "987654", "name": "Buddy", "category": {"id": "1", "name": "Dogs"}, "photoUrls": ["https://example.com/photo.jpg"], "tags": [{"id": "1", "name": "labrador"}], "status": "available"} |
    ...
    ...    *Steps:*    
    ...    - POST for creation Pet        
    ...
    ...    *Return:*
    ...    | =Description= | =Example value= |
    ...    | Response from the API after creating a pet | headers={'Date': 'Sun, 22 Mar 2026 09:07:30 GMT', 'Content-Type': 'application/json', 'Transfer-Encoding': 'chunked', 'Connection': 'keep-alive', 'Access-Control-Allow-Origin': '*', 'Access-Control-Allow-Methods': 'GET, POST, DELETE, PUT', 'Access-Control-Allow-Headers': 'Content-Type, api_key, Authorization', 'Server': 'Jetty(9.2.9.v20150224)'} body={"id":987654,"category":{"id":1,"name":"Dogs"},"name":"Buddy","photoUrls":["https://example.com/photo.jpg"],"tags":[{"id":1,"name":"labrador"}],"status":"available"}  |    
    [Arguments]    ${pet_body}
    ${response}    petstore_lib.LIB Create Pet    ${pet_body}
    Log    POST Response: ${response.json()}
    RETURN    ${response}
