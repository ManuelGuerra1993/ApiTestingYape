Feature: Ping

  Background: Url base
    Given url 'https://restful-booker.herokuapp.com'

  Scenario: Obtener todas las Booking ID
    Given path '/ping'
    When method GET
    Then status 201
    And print response