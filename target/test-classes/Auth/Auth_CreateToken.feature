Feature: Auth

  Background: Url base
    Given url 'https://restful-booker.herokuapp.com'

  Scenario: Test a sample GET API
    Given path '/auth'
    And request {"username" : "admin", "password" : "password123"}
    When method post
    Then status 200
    #And print response
  * def id = response.token
  * print id
    And match response == {"token": "id"}