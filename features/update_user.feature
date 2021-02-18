Feature: Update user
  As a admin
  I would like to be able to update info of a user.

    Background:
      Given a following user record
      | email             | full_name | status    |
      | admin@example.com | ADMIN     | published |
      | user@example.com  | JACK      | published |
      Given I am an admin and I am logged in
      Given I am at User list page
      When I click pencil icon on line of user list
      Then I should see user profile page

    Scenario: Update user with valid data
      When I update user with valid data
      Then I should see a update successfully message

    Scenario: Update user with invalid data
      When I update user with invalid karma
      Then I should see a invalid karma message



