*** Settings ***
Documentation     Testy API dla Petstore
Resource          ../Resources${/}Generic_keywords${/}gk_handler.resource

Suite Setup   fk_petstore.Open Session

*** Test Cases ***
Petstore Via RequestsLibrary
    [Documentation]    Test cases for Petstore API using RequestsLibrary.
    ...    DEPENDS_FROM_THE_PROJECT_WE_CAN_SHARE_LINK_TO_TEST_CASES_DESSIGN
    ...
    ...    *Steps / Expected*
    ...    - Create a new pet using POST /pet endpoint with valid details. / pass
    ...    - Verify the pet is created successfully by checking the response status code and body. / pass
    ...
    ...    *Requirements*
    ...    - ITEM_NUMBER/NAME_FROM_REQUIREMENT_BOARD
    ...
    ...    *Expected*
    ...    - Pet is created successfully and can be retrieved with correct details.
    [Tags]    petstore
    Create Session    petstore    https://petstore.swagger.io/v2

    # --- Prepare POST body ---
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

    # --- POST /pet ---
    ${post_response}    POST On Session
    ...    petstore
    ...    /pet
    ...    json=${pet_body}
    ...    expected_status=400

    Log    POST Response: ${post_response.json()}
    ${pet_id}    Set Variable    ${post_response.json()}[id]
    Should Be Equal As Strings    ${post_response.json()}[name]      Buddy
    Should Be Equal As Strings    ${post_response.json()}[status]    available

    # --- GET /pet/{petId} ---
    ${get_response}    GET On Session
    ...    petstore
    ...    /pet/${pet_id}
    ...    expected_status=200

    Log    GET Response: ${get_response.json()}
    Should Be Equal As Strings    ${get_response.json()}[id]      ${pet_id}
    Should Be Equal As Strings    ${get_response.json()}[name]    Buddy

Petstore Via FK Resource
    [Documentation]    Test case for Petstore API using custom resource keywords.
    ...    DEPENDS_FROM_THE_PROJECT_WE_CAN_SHARE_LINK_TO_TEST_CASES_DESSIGN
    ...
    ...    *Steps / Expected*
    ...    - Create a new pet using custom keyword that wraps POST /pet endpoint. / pass
    ...    - Verify the pet is created successfully by checking the response status code and body. / pass
    [Tags]    petstore_resource
    fk_petstore.Open Session
    ${pet_body}    fk_data_generator.Pet: Create Pet - Generate Json
    fk_petstore.Pet: Create Pet    ${pet_body}
    fk_petstore.Pet: Get Pet By ID    987654

Petstore Via GK Resource
    [Documentation]    Test case for Petstore API using custom resource keywords.
    ...    DEPENDS_FROM_THE_PROJECT_WE_CAN_SHARE_LINK_TO_TEST_CASES_DESSIGN
    ...
    ...    *Steps / Expected*
    ...    - Create a new pet using custom keyword that wraps POST /pet endpoint. / pass
    ...    - Verify the pet is created successfully by checking the response status code and body. / pass
    [Tags]    petstore_resource
    fk_petstore.Open Session
    ${pet_body}    fk_data_generator.Pet: Create Pet - Generate Json
    fk_petstore.Pet: Create Pet    ${pet_body}
    gk_petstore.Pet: Get & Verify Pet By ID    ${${pet_body}}[id]    ${${pet_body}}[name]    ${${pet_body}}[status]

Petstore Via GK Resource vol2
    [Documentation]    Test case for Petstore API using custom resource keywords.
    ...    DEPENDS_FROM_THE_PROJECT_WE_CAN_SHARE_LINK_TO_TEST_CASES_DESSIGN
    ...
    ...    *Steps / Expected*
    ...    - Create a new pet using custom keyword that wraps POST /pet endpoint. / pass
    ...    - Verify the pet is created successfully by checking the response status code and body. / pass
    [Tags]    petstore_resource_vol2
    gk_petstore.Pet: Create & Verify Pet By ID

Petstore Via Lib
    [Documentation]    Test case for Petstore API using custom library keywords.
    ...    DEPENDS_FROM_THE_PROJECT_WE_CAN_SHARE_LINK_TO_TEST_CASES_DESSIGN
    ...
    ...    *Steps / Expected*
    ...    - Create a new pet using custom library keyword that wraps POST /pet endpoint. / pass
    ...    - Verify the pet is created successfully by checking the response status code and body. / pass
    [Tags]    petstore_lib
    fk_petstore_lib.LIB Open Session
    ${pet_body}    fk_data_generator.Pet: Create Pet - Generate Json
    fk_petstore_lib.LIB Pet: Create Pet    ${pet_body}
    Log    ${ENV_VAR.url_petstore}