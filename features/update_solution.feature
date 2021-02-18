Feature: Update solution
  As an admin
  I would like to be able to update a solution

  Background:
    Given a following solution records
      | title             | status      |
      | Solution 1        | published   |
      | Solution 2        | published   |

    Scenario: Update a solution with valid data
      Given I am logged in
      And I am at Solution list page
      And I see a list of solutions like these
      | Title      | Created At   | Status       | Action  |
      | Solution 1 |              | Published    |         |
      | Solution 2 |              | Published    |         |
      When I click on the pencil icon of the first solution
      Then I should be redirected to edit solution screen
      When I change solution title and click update
      Then I should see updated title on screen

     Scenario: Update a solution with valid data
      Given I am logged in
      And I am at Solution list page
      And I see a list of solutions like these
      | Title      | Created At   | Status       | Action  |
      | Solution 1 |              | Published    |         |
      | Solution 2 |              | Published    |         |
      When I click on the pencil icon of the first solution
      Then I should be redirected to edit solution screen
      When I change solution with invalid title and click update
      Then I should see error message on edit screen  
