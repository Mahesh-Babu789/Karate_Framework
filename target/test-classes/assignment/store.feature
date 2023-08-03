Feature: Explore Store API

  Background:
    Given url 'https://petstore.swagger.io/v2'

#    Place an order for a pet
  Scenario: Pet store order End to End tests
    Given path '/store/order'
    And request
    """
  {
  "id": 123456,
  "petId": 0,
  "quantity": 5,
  "shipDate": "2023-08-03T07:39:14.780Z",
  "status": "placed",
  "complete": true
}
    """
    When method post
    Then status 200
    * def orderID = response.id
    And match response.status == "placed"

#    Get order by id
    Given path "/store/order/"+orderID
    When method get
    Then status 200
    And match response.id == 123456

#    Delete order by id
    Given path "/store/order/"+orderID
    When method delete
    Then status 200
    And match response.type == "unknown"
    And match response.message == "123456"

#    Fetch the pet store inventory
    Given path '/store/inventory'
    When method get
    Then status 200