Feature: display the details of a job for a given partnership
  As a concerned executive
  So that I can quickly see the details of a job assigned to a partnership
# Background: jobs have been added
#   Given the following jobs exist:
#   | JobNumber               | Partnership | Status   |
#   | 2021-0000               | 1A          | NEW      |
#   | 2021-0001               | 1B          | COMPLETE |
#   | 2021-0002               | 2A          | NEW      |
#   | 2021-0003               | 2B          | NEW      |
#   | 2021-0004               | 1C          | COMPLETE |
# #   And  I am on the BigEvent home page
#   Then 5 seed movies should exist
  
  Scenario: open job page
    When I go to job page for "2021-0000"
    Then I should be on job page "2021-0000"