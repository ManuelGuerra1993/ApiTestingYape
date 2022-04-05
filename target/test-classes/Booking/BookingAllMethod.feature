Feature: Booking

  Background: Url base
    Given url 'https://restful-booker.herokuapp.com'

  Scenario: Obtener todas las Booking ID
    Given path '/booking'
    When method GET
    Then status 200
    And print response


  Scenario: Obtener todas las Booking ID filtro por nombre y apellido
    Given path '/booking?firstname=sally&lastname=brown'
    When method GET
    Then status 404
    And print response


  Scenario: Obtener todas las Booking ID filtro por Check in y Check out
    Given path '/booking?checkin=2014-03-13&checkout=2014-05-21'
    When method GET
    Then status 404
    And print response


  Scenario: Obtener los datos de un booking
    Given path '/booking/1'
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And print response


  Scenario: Creacion de Booking
    Given path '/booking'
    And request {"firstname" : "Jim","lastname" : "Brown", "totalprice" : 111, "depositpaid" : true, "bookingdates" : { "checkin" : "2018-01-01", "checkout" : "2019-01-01" }, "additionalneeds" : "Breakfast" }
    And header Accept = 'application/json'
    When method post
    Then status 200
    And print response
    And match response == {"bookingid": "#ignore", "booking": { "firstname": "Jim", "lastname": "Brown", "totalprice": 111, "depositpaid": true, "bookingdates": { "checkin": "2018-01-01", "checkout": "2019-01-01" }, "additionalneeds": "Breakfast" } }


  Scenario: Actualizacion de Booking
    Given path '/auth'
    And request {"username" : "admin", "password" : "password123"}
    When method post
    * def id = response.token
    * print id

    Given path '/booking/1'
    And request { "firstname" : "James", "lastname" : "Brown", "totalprice" : 111, "depositpaid" : true, "bookingdates" : { "checkin" : "2018-01-01", "checkout" : "2019-01-01" }, "additionalneeds" : "Breakfast" }
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + id
    When method put
    Then status 200
    And print response
    And print responseStatus

    #And match response == {"createdAt": "#ignore", "id": "#string", "name": "Manuel", "job": "QA"}


  Scenario: Actualizacion Parcial de Booking
    Given path '/auth'
    And request {"username" : "admin", "password" : "password123"}
    When method post
    * def id = response.token
    * print id

    Given path '/booking/1'
    And request { "firstname" : "Manuel", "lastname" : "Guerra" }
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + id
    When method patch
    Then status 200
    And print response
    And print responseStatus

    #And match response == {"createdAt": "#ignore", "id": "#string", "name": "Manuel", "job": "QA"}

  Scenario: Delete de Booking
    Given path '/auth'
    And request {"username" : "admin", "password" : "password123"}
    When method post
    * def id = response.token
    * print id

    Given path '/booking/1'
    And header Content-Type = 'application/json'
    And header Cookie = 'token=' + id
    When method delete
    Then status 201
    And print response
    And print responseStatus