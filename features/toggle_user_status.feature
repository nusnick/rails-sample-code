Feature: Toggle user status
  As a admin
  I would like to be able to delete a user.

    Background:
      Given a following user record
      | email             | full_name | status    	|
      | admin@example.com | ADMIN     | published 	|
      | user@example.com  | JACK      | unpublished |
      Given I am logged in
      And I am at User list page

    Scenario: Publish a user     
      Given I see a list of users looks like
      | Email             | Fullname  | Status    	| Group     | Action    |
      | admin@example.com | ADMIN     | Published 	| Customer  |           |
      | user@example.com  | JACK      | Unpublished | Customer  |           |
      When I click on a tick icon of line in users list to publish JACK
      Then I should not see publish successfully message

    Scenario: Unpublish a user
      Given I see a list of users looks like
      | Email             | Fullname  | Status    	| Group     | Action    |
      | admin@example.com | ADMIN     | Published 	| Customer  |           |
      | user@example.com  | JACK      | Unpublished | Customer  |           |
      When I click on a tick icon of line in users list to unpublish ADMIN
      Then I should see unpublish successfully message

