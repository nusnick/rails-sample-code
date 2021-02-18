### TOGGLE STATUS SOLUTION ###
Given (/^I am at Solution list page$/) do
  visit solutions_path
end

Given (/^a following solution records$/) do |table|
  table.hashes.each do |h|
    FactoryGirl.create(:solution, :title => h[:title], :published => h[:status] == "published")
  end
end

Given (/^I see a list of solutions like these$/) do |table|
  table.hashes.each do |h|
    page.should have_content h[:Title]
    page.should have_content h[:Status]
  end
end

When (/^I click on the tick icon in one line of solution list$/) do
  first(".toggle-status").click
end

Then (/^I should see a message says that solution status has been changed successfully$/) do
  page.should have_content("Unpublished")
  page.should have_content("successfully")
end

When (/^I click on the trash icon of the first solution$/) do
  first(".delete-solution").click
end

Then (/^I should not see that solution on solution list page any more$/) do
  page.should_not have_content("Solution 1")
end

Then (/^I should see a message says that solution has been deleted successfully$/) do
  page.should have_content I18n.t("solutions.deleted_successfully")
end


### CREATE SOLUTION ###
Given (/^I am at New solution page$/) do
  visit new_solution_path
end

When (/^I enter valid info into solution form$/) do
  fill_in "solution[title]", with: "Test Title"
  click_button "Save"
end

Then (/^I should see new solution in solution list page$/) do
  page.should have_content Solution.last.title
end

When (/^I enter invalid info into solution form$/) do
  fill_in "solution[title]", with: ""
  click_button "Save"
end

Then (/^I should see error message on screen$/) do
  page.should have_content "Create New Solution"
  page.should have_content "Title can't be blank"
end


### UPDATE SOLUTION ###
When (/^I click on the pencil icon of the first solution$/) do
  first(".update-solution").click
end

Then (/^I should be redirected to edit solution screen$/) do
  page.should have_content "Edit Solution"
end

When (/^I change solution title and click update$/) do
  fill_in "solution[title]", with: "New solution title"
  click_button "Save"
end

Then (/^I should see updated title on screen$/) do
  page.should_not have_content "Edit Solution"
  page.should have_content "New solution title"
end

When(/^I change solution with invalid title and click update$/) do
  fill_in "solution[title]", with: ""
  click_button "Save"
end

Then(/^I should see error message on edit screen$/) do
  page.should have_content "Edit Solution"
  page.should have_content "Title can't be blank"
end
