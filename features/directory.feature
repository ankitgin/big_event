Feature: display all users in the staff directory
  As an Executive
  So that I can see the information about individual staff members 
  I want to be able to view all users in a table
  
Background: users have been added to database
  Given the following users exist:
  | email                   | level |
  | chemsworth@tamu.edu     | EX    |
  | csembera@tamu.edu       | CM    |
  | example@tamu.edu        | SA    |

  # Scenario: Deny non-executive access
  #   Given I am not an Executive


  Scenario: View all users in Table
    Given I am an Executive
    When I am on the users page
    Then I should see all users