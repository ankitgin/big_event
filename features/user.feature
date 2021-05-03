Feature: authenticate users to be logged in
  As a staff member
  So that I can login to access job information
  I want to be able to login
  
Background: users have been added to database
  Given the following users exist:
  | email                   | level
  | chemsworth@tamu.edu     | EZ
  | csembera@tamu.edu       | CM
  | example@tamu.edu        | SA

  Scenario: User clicks to login
    When I am on the HomePage
    And I press "Log In with Google"
    Then I should be on the authentication page
