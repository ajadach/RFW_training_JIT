import requests
from robot.api.deco import keyword

# class name need to be the same as file, in other case you will get an error:
# [ WARN ] Imported library 'C:\RFW_DAY1\RFW_training_JIT\Libs\petstore_lib.py' contains no keywords.
class petstore_lib:

    def __init__(self):
        self.url = None

    @keyword('LIB Open Session')
    def lib_open_session(self, url):
        """
        Open a session with the Petstore API.

        *Arguments:*
        | =Name= | =Description= | =Example Value= |
        | url | The base URL of the Petstore API. | http://petstore.swagger.io/v2 |

        *Return Value:*
        | Nothing, None. |
        """
        self.url = url

    @keyword('LIB Create Pet')
    def lib_create_pet(self, body):
        """
        Create a new pet in the Petstore API.

        *Arguments:*
        | =Name= | =Description= | =Example Value= |
        | body | The JSON body of the pet to create. | {"id": 1, "name": "Dog", "status": "available"} |

        *Return Value:*
        | The response from the API call. |
        """
        response = requests.post(f"{self.url}/pet", json=body)
        return response
    
    @keyword('LIB Get Pet')
    def lib_get_pet(self, pet_id):
        """
        Get a pet by ID from the Petstore API.

        *Arguments:*
        | =Name= | =Description= | =Example Value= |
        | pet_id | The ID of the pet to retrieve. | 1 |

        *Return Value:*
        | The response from the API call. |
        """
        response = requests.get(f"{self.url}/pet/{pet_id}")
        return response
