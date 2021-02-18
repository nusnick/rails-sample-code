Feature: Delete user
  As a admin
  I would like to be able to delete a user.

    Background:
      Given a following user record
      | email             | full_name | status    |
      | admin@example.com | ADMIN     | published |
      | user@example.com  | JACK      | published |
      Given I am logged in
      And I am at User list page

    Scenario: Delete a user     
      Given I see a list of users looks like
      | Email             | Fullname  | Status    | Group     | Action    |
      | admin@example.com | ADMIN     | Published | Customer  |           |
      | user@example.com  | JACK      | Published | Customer  |           |
      When I click on a trash icon of line in users list to delete JACK
      Then I should not see user just deleted

    Scenario: Delete a user has solution or specialization
      Given I see a list of users looks like
      | Email             | Fullname  | Status    | Group     | Action    |
      | admin@example.com | ADMIN     | Published | Customer  |           |
      | user@example.com  | JACK      | Published | Customer  |           |
      And JACK has one solution
      When I click on a trash icon of line in users list to delete JACK
      Then I should see cannot delete message

