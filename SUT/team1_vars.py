class Structure:
    def __init__(self, **entries):
        self.__dict__.update(entries)

VARIABLES_OBJ = {
    'TEST01': Structure(**{
        'url_petstore': 'https://petstore.swagger.io/v2 TEST01',
    }),
    'TEST02': Structure(**{
        'url_petstore': 'https://petstore.swagger.io/v2 TEST02',
    }),
    'DEV01': Structure(**{
        'url_petstore': 'https://petstore.swagger.io/v2 DEV01',
    }),
}

OBJ_VAR = Structure(**VARIABLES_OBJ)

TEMP_VAL = 'asd'

# python -m robot -v ENV:DEV01 -V SUT/team1_vars.py -i petstore_lib -L TRACE C:\RFW_DAY1\RFW_training_JIT\Tests\Artur\test_petstore.robot
