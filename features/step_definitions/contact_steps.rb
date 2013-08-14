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

Given(/^I have the following contacts$/) do |table|
  table.hashes.each do |a|
    Contact.create!(name: a[:name], email: a[:email], company_id: Company.find_by_name(a[:company]).id)
  end
end

When(/^I click the first clickable row$/) do
  first(:xpath, "//tr[@onclick]").click()
end

When(/^I click the "(.*?)" button$/) do |button|
  click_button(button)
end