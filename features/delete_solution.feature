Feature: Delete solution
  As an admin
  I would like to be able to delete a solution

    Background:
      Given a following solution records
      | title             | status      |
      | Solution 1        | published   |
      | Solution 2        | published   |

    Scenario: Delete a solution
      Given I am logged in
      And I am at Solution list page
      And I see a list of solutions like these
      | Title      | Created At   | Status       | Action  |
      | Solution 1 |              | Published    |         |
      | Solution 2 |              | Published    |         |
      When I click on the trash icon of the first solution
      Then I should not see that solution on solution list page any more
      And I should see a message says that solution has been deleted successfully
