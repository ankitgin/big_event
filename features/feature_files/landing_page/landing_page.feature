Feature: go to the home page
  As a staff assistant
  So that I can login and navigate to other pages though various buttons and links
  I want to navigate to other pages to view partnership information

  Background:
    Given I am on the "HomePage"

  Scenario: Landing page
    Then I should see the following: "Online Student Sign" "Job Request Form" "Committee Services" "Home" "Job Request" "Sign Up" "Log In with Google"

  Scenario: Follow Home
    And I follow "home"
    Then I should be on the "HomePage"

  Scenario: Click "Committee Services"
    When I follow "committee_services_btn"
    Then I should be on the "HomePage"
    And I should see "User not signed in"

#  Scenario: Click "Committee Services"
#    When I am logged in
#    And I press "Committee Services"
#    Then I should be on the "Partnership" page

#  Scenario: Follow Job Request
#    When I follow "jobrequest"
#    Then I should be on the "Job Request" page

#  Scenario: Follow "Sign Up"
#    When I follow "signup"
#    Then I should be on the "Sign Up" page

#  Scenario: Click "Job Request Form"
#    When I press "jobrequest_btn"
#    Then I should be on the "Job Request" page
#
#  Scenario: Click "Online Student Sign-Up"
#    When I press "signup_btn"
#    Then I should be on the "Sign Up" page
