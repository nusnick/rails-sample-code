### CREATE SOLUTION SPECIALIZATION ###
Given(/^I am at New solution specialization page$/) do
  visit new_solution_specialization_path
end

When(/^I enter valid info into solution specialization form$/) do
  fill_in "solution_specialization[title]", with: "My solution specialization"
  click_button "Save"
end

Then(/^I should see new solution in solution specialization list page$/) do
  page.should have_content("Create Specialization")
  page.should have_content("My solution specialization")
end

When(/^I enter invalid info into solution specialization form$/) do
  fill_in "solution_specialization[title]", with: ""
  click_button "Save"
end

Then(/^I should see error message on new solution specialization screen$/) do
  page.should have_content("Create Specialization")
  page.should have_content("Title can't be blank")
end


### UPDATE SOLUTION SPECIALIZATION ###
Given(/^a following solution specialization records$/) do |table|
  table.hashes.each do |h|
    FactoryGirl.create(:solution_specialization, title: h[:title], published: h[:status] == "published")
  end
end

Given(/^I am at Solution Specialization list page$/) do
  visit solution_specializations_path
end

Given(/^I see a list of solution specializations like these$/) do |table|
  table.hashes.each do |h|
    page.should have_content(h[:Title])
    page.should have_content(h[:Status])
  end
end

When(/^I click on the pencil icon of the first solution specialization$/) do
  first(".edit-spec").click
end

Then(/^I should be redirected to edit solution specialization screen$/) do
  page.should have_content("Edit Solution Specialization")
  page.should have_button("Save")
end

When(/^I change solution specialization title and click update$/) do
  fill_in "solution_specialization[title]", with: "Editing specialization"
  click_button "Save"
end

Then(/^I should see updated specialization title on screen$/) do
  page.should_not have_content "Edit Solution Specialization"
  page.should have_field "solution_specialization[title]", with: "Editing specialization"
end

When(/^I change solution specialization with invalid title and click update$/) do
  fill_in "solution_specialization[title]", with: ""
  click_button "Save"
end

Then(/^I should see error message on edit solution specialization screen$/) do
  page.should have_content("Edit Solution Specialization")
  page.should have_content("Title can't be blank")
end


### DELETE SOLUTION SPECiALIZATION ###
When(/^I click on the trash icon of the first solution specialization$/) do
  first(".delete-spec").click
end

Then(/^I should not see that solution specialization on solution specializations list page any more$/) do
  page.should_not have_content("Solution Specialization 1")
end

Then(/^I should see a message says that solution specialization has been deleted successfully$/) do
  page.should have_content I18n.t("solution_specs.deleted_successfully")
end


### TOGGLE STATUS ###
When(/^I click on the tick icon in one line of solution specialization list$/) do
  first(".toggle-status").click
end

Then(/^I should see a message says that solution specialization status has been changed successfully$/) do
  page.should have_content("Unpublished")
  page.should have_content("successfully")
end

Given(/^Solution Specialization (\d+) belongs to one solution$/) do |arg1|
  solution = FactoryGirl.create :solution
  SolutionSpecialization.first.solutions << solution
end

Then(/^I should see a message cannot unpublish solution specialization$/) do
  page.should_not have_content "Unpublished"
  page.should have_content I18n.t("solution_specs.cannot_unpublished")
end

