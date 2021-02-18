Feature: Delete solution specialization
  As an admin
  I would like to be able to delete a solution

    Background:
      Given a following solution specialization records
      | title                            | status      |
      | Solution Specialization 1        | published   |
      | Solution Specialization 2        | published   |

    Scenario: Delete a solution specialization
      Given I am logged in
      And I am at Solution Specialization list page
      And I see a list of solution specializations like these
      | Title                     | Created At   | Status       | Action  |
      | Solution Specialization 1 |              | Published    |         |
      | Solution Specialization 2 |              | Published    |         |
      When I click on the trash icon of the first solution specialization
      Then I should not see that solution specialization on solution specializations list page any more
      And I should see a message says that solution specialization has been deleted successfully
