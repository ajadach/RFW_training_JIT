*** Settings ***
Library    BuiltIn
Library    Collections
Library    RequestsLibrary
Library    ../Libs/petstore_lib.py

*** Variables ***
${ENV}    TEST02
${ENV_VAR}    ${OBJ_VAR.${ENV}}
