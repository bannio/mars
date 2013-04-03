Then(/^I should see a list of contacts$/) do
  page.should have_selector('h1#contacts-index-page')
end

Then(/^I can create a new contact for "(.*?)"$/) do |company|
  # select(company, from: 'Company')
  # select(company, from: 'Address')
  fill_in('Name', with: 'My Contact')
  click_button('Create Contact')
end

Given(/^the contact "(.*?)" exists$/) do |name|
  create_contact(name)
end

Then(/^I can change the contact$/) do
  fill_in('Name', with: 'new name')
  click_button('Update Contact')
end

When (/^I click on "New" against "Contacts"$/) do
  click_link('new-contact')
end