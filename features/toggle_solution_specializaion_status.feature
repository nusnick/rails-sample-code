Feature: Toggle solution specialization status
  As an admin
  I would like to be able to change status of a solution

    Background:
      Given a following solution specialization records
      | title                            | status      |
      | Solution Specialization 1        | published   |
      | Solution Specialization 2        | published   |

    Scenario: Toggle solution's status
      Given I am logged in
      And I am at Solution Specialization list page
      And I see a list of solution specializations like these
      | Title                     | Created At   | Status       | Action  |
      | Solution Specialization 1 |              | Published    |         |
      | Solution Specialization 2 |              | Published    |         |
      When I click on the tick icon in one line of solution specialization list
      Then I should see a message says that solution specialization status has been changed successfully

    Scenario: Unpulish specialization belongs to one or many solutions
      Given I am logged in
      And I am at Solution Specialization list page
      And I see a list of solution specializations like these
      | Title                     | Created At   | Status       | Action  |
      | Solution Specialization 1 |              | Published    |         |
      | Solution Specialization 2 |              | Published    |         |
      And Solution Specialization 1 belongs to one solution
      When I click on the tick icon in one line of solution specialization list
      Then I should see a message cannot unpublish solution specialization