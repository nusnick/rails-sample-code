Feature: Create Solution
  As an admin
  I would like to be able to create new solution

  Background:
    Given I am an admin and I am logged in
    And I am at New solution page

  Scenario: Create solution with valid data
    When I enter valid info into solution form
    Then I should see new solution in solution list page

  Scenario: Create solution with invalid data
    When I enter invalid info into solution form
    Then I should see error message on screen
