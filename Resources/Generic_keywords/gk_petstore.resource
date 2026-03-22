*** Settings ***
Resource    ..${/}Functional_keywords${/}fk_handler.resource


*** Keywords ***
Pet: Get & Verify Pet By ID
    [Documentation]    Keyword to get pet details and verify the response.
    ...
    ...    *Arguments:*
    ...    | ${pet_id} | The ID of the pet to retrieve |
    ...
    ...    *Return:*
    ...    | ${response} | The response object from the API call |
    [Arguments]    ${pet_id}    ${expected_name}    ${expected_status}=None
    ${response}    fk_petstore.Pet: Get Pet By ID    ${pet_id}
    Should Be Equal As Strings    ${response}[name]    ${expected_name}
    Log   GET Response: ${response}

Pet: Create & Verify Pet By ID
    [Documentation]    Keyword to create a pet and verify its details by ID.   
    ${pet_body}    fk_data_generator.Pet: Create Pet - Generate Json
    fk_petstore.Pet: Create Pet    ${pet_body}
    gk_petstore.Pet: Get & Verify Pet By ID    ${pet_body['id']}    ${pet_body['name']}    ${pet_body['status']}
