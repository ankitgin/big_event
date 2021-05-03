Feature: Login to Big Event Internal using Google account
  As a staff member
  So that I can access the information I have permission to view
  I want to be able to login with my TAMU Google Account
  
Background: users have been added to database
  Given the following users exist:
  | email                   | firstname | lastname   |
  | chemsworth@tamu.edu     | Claire    | Hemsworth  |
  | csembera@tamu.edu       | Canyon    | Sembera    |
  | example@tamu.edu        | Example   | Example    |

  Scenario: Log in as Executive
    Given I, "chemsworth@tamu.edu", am an "EX" level
    When I log in as "chemsworth@tamu.edu"
    Then I should be on the "HomePage"
    Then I should see the following: "Welcome Claire Hemsworth!" "Log out" "Staff Directory"

  Scenario: Log in as Committee Member
    Given I, "chemsworth@tamu.edu", am an "CM" level
    When I log in as "chemsworth@tamu.edu"
    Then I should be on the "HomePage"
    Then I should see the following: "Welcome Claire Hemsworth!" "Log out"
    Then I should not see "Staff Directory"

  Scenario: Log in as Staff Assistant
    Given I, "chemsworth@tamu.edu", am an "SA" level
    When I log in as "chemsworth@tamu.edu"
    Then I should be on the "HomePage"
    Then I should see the following: "Welcome Claire Hemsworth!" "Log out"
    Then I should not see "Staff Directory"

  Scenario: Logout
    Given I am logged in as "chemsworth@tamu.edu"
    When I follow "Log out"
    Then I should see "Log In with Google"
    Then I should not see "Claire Hemsworth" 
    Then I should not see "Staff Directory"

Scenario: Log in as Non Staff Member
  Given the staff member, "chemsworth@tamu.edu", is removed from the directory
  When I log in as "chemsworth@tamu.edu" 
  Then I should be redirected to "https://bigevent.tamu.edu/"
