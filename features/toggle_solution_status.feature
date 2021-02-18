Feature: Toggle solution status
  As an admin
  I would like to be able to change status of a solution

    Background:
      Given a following solution records
      | title             | status      |
      | Solution 1        | published   |
      | Solution 2        | published   |

    Scenario: Toggle solution's status
      Given I am logged in
      And I am at Solution list page
      And I see a list of solutions like these
      | Title      | Created At   |  Status       | Action  |
      | Solution 1 |              |  Published    |         |
      | Solution 2 |              |  Published    |         |
      When I click on the tick icon in one line of solution list
      Then I should see a message says that solution status has been changed successfully