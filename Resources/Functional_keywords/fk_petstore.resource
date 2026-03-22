*** Settings ***
Documentation     Keywords related to Petstore API testing.
Resource          lib_handler.resource


*** Keywords ***
Open Session
    [Documentation]    Create Session to petstore API. This keyword can be reused in multiple test cases to establish a connection with the API.
    ...
    ...    *Steps:*    
    ...    - Setup petstore as a alias for the session   
    ...
    ...    *Return:*
    ...    | =Description= | =Example value= |
    ...    | Nothing | None |
    Create Session    petstore    https://petstore.swagger.io/v2

Create Pet
    [Documentation]    Create a new pet in the Petstore API.
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
    ${response}    POST On Session
    ...    petstore
    ...    /pet
    ...    json=${pet_body}
    ...    expected_status=200
    Log    POST Response: ${response.json()}
    RETURN    ${response}

Pet: Create Pet
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
    ${response}    POST On Session
    ...    petstore
    ...    /pet
    ...    json=${pet_body}
    ...    expected_status=200
    Log    POST Response: ${response.json()}
    RETURN    ${response}

Pet: Get Pet By ID
    [Documentation]    Retrieve a pet by its ID from the Petstore API.
    ...    *Arguments*
    ...    | =Name= | =Description= | =Example value= |
    ...    | pet_id | The ID of the pet to retrieve | 987654 |
    ...
    ...    *Steps:*
    ...    - GET pet details by ID
    ...
    ...    *Return:*
    ...    | =Description= | =Example value= |
    ...    | Response from the API with pet details | |
    [Arguments]    ${pet_id}
    ${get_response}    GET On Session
    ...    petstore
    ...    /pet/${pet_id}
    ...    expected_status=200
    Log    GET Response: ${get_response.json()}
    RETURN    ${get_response.json()}
