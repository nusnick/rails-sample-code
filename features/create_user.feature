Feature: Create user
  As a admin
  I would like to be able to create a user.

    Background:
      Given I am an admin and I am logged in
      Given I am at New user page

    Scenario: Create user with valid data
      When I create with valid user data
      Then I should see a list of users contains user just created

    Scenario: Create user with invalid data
      When I create with invalid email
      Then I should see an invalid email message

