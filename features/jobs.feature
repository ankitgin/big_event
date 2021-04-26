Feature: display the details of a job for a given partnership
  As a concerned executive
  So that I can quickly see the details of a job assigned to a partnership
  
Background: jobs have been added to database
  Given the following jobs exist:
  | JobNumber               | Partnership | Status   |
  | 2022-0000               | 1A          | NEW      |
  | 2022-0001               | 1B          | TEST     |
  | 2022-0002               | 2A          | NEW      |
  | 2022-0003               | 2B          | NEW      |
  | 2022-0004               | 1C          | COMPLETE |

  Scenario: Dummy test
    When I am on the HomePage
    Then I am on the HomePage testing
  
  Scenario: Delete the test set jobs from the database
    When I delete the jobs "2022-0000, 2022-0001, 2022-0002, 2022-0003, 2022-0004"
    Then I should not see the the jobs "2022-0000, 2022-0001, 2022-0002, 2022-0003, 2022-0004"