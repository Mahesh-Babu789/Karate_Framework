Feature: Explore pet API endpoint
  Background:
    * url 'https://petstore.swagger.io/v2'

#    Add a new pet to the pet store
  Scenario: Pet End to End tests
    Given path '/pet'
    And request
    """
{
  "id": 123456,
  "category": {
    "id": 0,
    "name": "string"
  },
  "name": "Tommy",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "Doggy"
    }
  ],
  "status": "available"
}
    """
    When method post
    Then status 200
    * def petId = response.id
    And match response.id == petId

#    Update a pet using put request
    Given path '/pet'
    And request
    """
    {
  "id": 0,
  "category": {
    "id": 0,
    "name": "string"
  },
  "name": "pussy",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "cat"
    }
  ],
  "status": "available"
}
    """
    When method put
    Then status 200
    Then response.name == "pussy"
    And match response.tags[0].name == "cat"

#    Get pets using pet name and validate
    Given path '/pet/findByStatus'
    Given param status = 'available,pending,sold'
    When method get
    Then status 200

#   Fetch pet by per id
    Given path "/pet/"+petId
    When method get
    Then status 200
    And match response.name == "Tommy"

#    Update a pet in the store with form data
    Given path "/pet/"+petId
    And form field name = 'Jerry'
    And form field status = 'pending'
    When method post
    Then status 200
    And match response.message == "123456"

#    Upload image
    Given path "pet/"+petId+"/uploadImage"
    And multipart file file = { read: 'Dancing_banana.gif', filename: 'Dancing_banana.gif', content-type: 'multipart/form-data' }
    When method post
    Then status 200
    And match response.message == "additionalMetadata: null\nFile uploaded to ./Dancing_banana.gif, 4354 bytes"

#    Delete a pet by id

    Given path "/pet/"+petId
    When method delete
    Then status 200
    And match response.message == "123456"

