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

  Scenario: View all users in Table
    Given I am logged in as "chemsworth@tamu.edu"
    When I follow "Staff Directory"
    Then I should be on the "Staff Directory" page
    Then I should see all users

  Scenario: Update user database from CSV
    Given I am logged in as "chemsworth@tamu.edu"
    When I follow "Staff Directory"
    Then I upload "Mock_Staff_Directory.csv"
    Then I should see "mscotty@tamu.edu"

  Scenario: Export user database to CSV
    Given I am logged in as "chemsworth@tamu.edu"
    When I follow "Staff Directory"
    And I follow "Export to CSV"
    Then I should receive the csv file: "TBE-staff-directory.csv"
  
  Scenario: Verify user database information in CSV
    Given the exported file, "TBE-staff-directory.csv", exists
    Then "TBE-staff-directory.csv" should contain the database information