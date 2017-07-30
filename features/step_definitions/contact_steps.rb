Then(/^I should see a list of contacts$/) do
  page.should have_selector('h1#contacts-index-page')
end

Then(/^I can create a new contact for "(.*?)"$/) do |company|
  # select(company, from: 'Company')
  # select(company, from: 'Address')
  fill_in('Name', with: 'My Contact')
  select('Primary', from: 'Address')
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
    create(:contact, name: a[:name], email: a[:email], company_id: Company.find_by_name(a[:company]).id)
  end
end

Given(/^"([^"]*)" has at least one address$/) do |arg1|
  company = Company.find_by_name(arg1)
  address = create(:address, company_id: company.id, name: 'Primary')
end

# When(/^I click the first clickable row$/) do   # NOTE that onclick is not used now!
#   first(:xpath, "//tr[@onclick]").click()
# end

When(/^I click the "(.*?)" button$/) do |button|
  click_button(button)
end

Given(/^I am on the contacts page for "(.*?)"$/) do |contact|
  @contact = create_contact(contact)
  visit company_contact_path(@company, @contact)
  page.should have_content(contact)
end