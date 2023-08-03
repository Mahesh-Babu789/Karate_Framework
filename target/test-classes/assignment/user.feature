Feature: Explore Users API
  Background:
    Given url 'https://petstore.swagger.io/v2'

#    Create user with an array
  Scenario: user api End to End tests
    Given path '/user/createWithArray'
    And request
      """
   [
  {
    "username": "Tom22",
    "firstName": "Charlene",
    "lastName": "Carroll",
    "email": "Josefina_Tromp@hotmail.com",
    "password": "yTtRtxnWsGOk9Yd",
    "phone": "711-283-9423",
    "userStatus": 1
},
{
    "username": "John1",
    "firstName": "Delmer",
    "lastName": "Kuphal",
    "email": "Maia_Bartoletti33@gmail.com",
    "password": "ALk5zIEs7gUsjnU",
    "phone": "633-378-7729",
    "userStatus": 1
}
]
      """
    When method POST
    Then status 200
    And match response.message == 'ok'

#    Fetch user by name
    Given path '/user/Tom22'
    When method Get
    Then status 200
    And match response.username == "Tom22"
    And match response.firstName == "Charlene"

#    Create user using list
    Given path '/user/createWithList'
    And request
      """
      [
  {
    "username": "John2",
    "firstName": "Delmer2",
    "lastName": "Kuphal2",
    "email": "Maia_Bartoletti34@gmail.com",
    "password": "BLk5zIEs7gUsjnU",
    "phone": "633-378-7730",
    "userStatus": 1
}]
      """
    When method POST
    Then status 200
    And match response.type == "unknown"

    #    Update user using put request
    Given path '/user/John2'
    And request
      """
  {
    "username": "John20",
    "firstName": "Delmer20",
    "lastName": "Kuphal2",
    "email": "Maia_Bartoletti34@gmail.com",
    "password": "BLk5zIEs7gUsjnU",
    "phone": "633-378-7730",
    "userStatus": 1
}
      """
    When method put
    Then status 200
    And match response.type == "unknown"

#    Delete a user
    Given path '/user/John2'
    When method Delete
    Then status 200
    And match response.type == "unknown"

#    User logs in to the system
    Given path 'user/login'
    And param username = "John20"
    And param password = "BLk5zIEs7gUsjnU"
    When method Get
    Then status 200
    And match response.type == "unknown"

#    User logs out
    Given path '/user/logout'
    When method Get
    Then status 200
    And match response.message == "ok"

#    Add a single user
    Given path 'user'
    And request
    """
    {
    "username": "John25",
    "firstName": "Delmer25",
    "lastName": "Kuphal5",
    "email": "Maia_Bartoletti25@gmail.com",
    "password": "BLk5zIEs7gUsjnU",
    "phone": "633-378-7725",
    "userStatus": 1
}
    """
    When method post
    Then status 200
    And match response.type == "unknown"





