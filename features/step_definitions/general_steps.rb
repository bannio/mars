def create_company_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, name: @visitor[:name], email: @visitor[:email], roles_mask: 3)
end

def create_company(name)
  @company = FactoryGirl.create(:company, name: name)
end

def create_contact(name)
  @company = @company ||= FactoryGirl.create(:company)
  @address = @address ||= FactoryGirl.create(:address, company_id: @company.id, name: name)
  @contact = FactoryGirl.create(:contact, company_id: @company.id, address_id: @address.id, name: name)
end

def create_address(name)
  @company = @company ||= FactoryGirl.create(:company)
  @address = FactoryGirl.create(:address, company_id: @company.id, name: name)
end


Given(/^I visit the home page$/) do
  visit '/'
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.has_content?(arg1).should be_true
end

Given(/^I am logged in as a user with a role "(.*?)"$/) do |role|
  create_company_user if role == 'company'
  sign_in
end

Then(/^I should see a list of addresses$/) do
  page.should have_content "Listing Addresses"
end

Given(/^the company "(.*?)" exists$/) do |company|
  create_company(company)
end

Then(/^I can create a new address for "(.*?)"$/) do |company|
  select(company, from: 'Company')
  fill_in('Name', with: 'My address')
  click_button('Create Address')
end

Then(/^I should see a successfully created message$/) do
  page.should have_content 'was successfully created'
end

Given(/^I am on the "(.*?)" page$/) do |arg1|
  visit "/#{arg1}"
end

Given(/^the address "(.*?)" exists$/) do |name|
  create_address(name)
end

Then(/^I can change the address$/) do
  fill_in('Address', with: "new address")
  click_button('Update Address')
end

Then(/^I should see a successfully updated message$/) do
  page.should have_content 'was successfully updated'
end

Then(/^if I try to visit the (.*?) page$/) do |page|
  visit "/#{page}"
end

Then(/^I should see a list of contacts$/) do
  page.should have_content "Listing Contacts"
end

Then(/^I can create a new contact for "(.*?)"$/) do |company|
  select(company, from: 'Company')
  select(company, from: 'Address')
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