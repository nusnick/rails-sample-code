Feature: Create Solution Specialization
  As an admin
  I would like to be able to create new solution specialization

  Background:
    Given I am an admin and I am logged in
    And I am at New solution specialization page

  Scenario: Create solution specialization with valid data
    When I enter valid info into solution specialization form
    Then I should see new solution in solution specialization list page

  Scenario: Create solution specialization with invalid data
    When I enter invalid info into solution specialization form
    Then I should see error message on new solution specialization screen
