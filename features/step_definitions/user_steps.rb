### UTILITY METHODS ###

def create_admin
  @admin = FactoryGirl.create :user
  @admin.update_attributes({:role_ids => [Role.create({:name => "super_admin"}).id]})
  Role.create(:name => "admin")
end

def create_user h
 u = FactoryGirl.create(:user, email: h[:email], published: h[:status] == "published", full_name: h[:full_name])
 u.add_role(:admin)
end

def find_user email
  @user = User.find_by_email(email)
end

def delete_user email
  @user = find_user(email)
  @user.destroy unless @user.nil?
end

def log_in
  create_admin
  visit "/auth/login"
  fill_in "user_email", :with => @admin.email
  fill_in "user_password", :with => @admin.password
  click_button "Sign In"
end





### CREATE USER ###

Given(/^I am an admin and I am logged in$/) do
  log_in
  page.should_not have_button "Sign In"
end

Given(/^I am at New user page$/) do
  visit new_user_path
end

When(/^I create with valid user data$/) do
  fill_in "user[full_name]", :with => "JACK"
  fill_in "user_email", :with => "user@example.com"
  select "Admin", :from => "user[role]"
  click_button "Create"
end

Then(/^I should see a list of users contains user just created$/) do
  page.should have_link "Create New User"
  User.count.should eq(2)
end

When(/^I create with invalid email$/) do
  fill_in "user[full_name]", :with => "JACK"
  fill_in "user_email", :with => @admin.email
  click_button "Create"
end

Then(/^I should see an invalid email message$/) do
  page.should have_content "Email has already been taken"
end



### DELETE USER ###

Given(/^a following user record$/) do |table|
  table.hashes.each do |h|
    create_user h
  end
end

Given(/^I am logged in$/) do
 log_in
end

Given(/^I am at User list page$/) do
  visit users_path
end

Given(/^I see a list of users looks like$/) do |table|
  page.should have_content "user@example.com"
end

When(/^I click on a trash icon of line in users list to delete JACK$/) do
  click_link "btn-delete-#{find_user('user@example.com').id}"
end

Then(/^I should not see user just deleted$/) do
  page.should_not have_content("user@example.com")
end

Given(/^JACK has one solution$/) do
  user = find_user('user@example.com')
  solution = FactoryGirl.create :solution
  user.solutions << solution
  click_link "btn-delete-#{user.id}"
end

Then(/^I should see cannot delete message$/) do
   page.should have_content("Cannot delete user")
end





### UPDATE USER ###

When(/^I click pencil icon on line of user list$/) do
  click_link "btn-edit-#{find_user('user@example.com').id}"
end

Then(/^I should see user profile page$/) do
  page.should have_content "User Profile"
  page.should have_content "Update"
end

When(/^I update user with valid data$/) do
  fill_in "user_full_name", :with => "I AM TESTING"
  click_button "Update"
end

Then(/^I should see a update successfully message$/) do
  page.should have_content "User has been updated successfully."
  page.should have_content "I AM TESTING"
end

When(/^I update user with invalid karma$/) do
  fill_in "user_karma", :with => "acb"
  click_button "Update"
end

Then(/^I should see a invalid karma message$/) do
  page.should have_content "Karma must be from 0 to 5000."
end



### TOOGLE USER'S STATUS ###
When(/^I click on a tick icon of line in users list to publish JACK$/) do
  click_link "btn-status-#{find_user('user@example.com').id}"
end

Then(/^I should not see publish successfully message$/) do
  page.should have_content I18n.t("users.published_successfully")
end

When(/^I click on a tick icon of line in users list to unpublish ADMIN$/) do
  click_link "btn-status-#{find_user('admin@example.com').id}"
end

Then(/^I should see unpublish successfully message$/) do
  page.should have_content I18n.t("users.unpublished_successfully")
end




