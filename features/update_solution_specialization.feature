Feature: Update solution specialization
  As an admin
  I would like to be able to update a solution specialization

  Background:
    Given a following solution specialization records
      | title                            | status      |
      | Solution Specialization 1        | published   |
      | Solution Specialization 2        | published   |

    Scenario: Update a solution specialization with valid data
      Given I am logged in
      And I am at Solution Specialization list page
      And I see a list of solution specializations like these
      | Title                     | Created At   | Status       | Action  |
      | Solution Specialization 1 |              | Published    |         |
      | Solution Specialization 2 |              | Published    |         |
      When I click on the pencil icon of the first solution specialization
      Then I should be redirected to edit solution specialization screen
      When I change solution specialization title and click update
      Then I should see updated specialization title on screen

     Scenario: Update a solution with valid data
      Given I am logged in
      And I am at Solution Specialization list page
      And I see a list of solution specializations like these
      | Title                     | Created At   | Status       | Action  |
      | Solution Specialization 1 |              | Published    |         |
      | Solution Specialization 2 |              | Published    |         |
      When I click on the pencil icon of the first solution specialization
      Then I should be redirected to edit solution specialization screen
      When I change solution specialization with invalid title and click update
      Then I should see error message on edit solution specialization screen
