def create_company_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, name: @visitor[:name], email: @visitor[:email], roles_mask: 3)
end

def create_company(name)
  @company = FactoryGirl.create(:company, name: name)
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
  page.should have_content "Listing addresses"
end

Given(/^the company "(.*?)" exists$/) do |company|
  create_company(company)
end

Then(/^I can create a new address for "(.*?)"$/) do |company|
  select(company, from: 'Company')
  fill_in('address_name', with: 'My address')
  click_button('Create Address')
end

Then(/^I should see a successfully created message$/) do
  page.should have_content 'was successfully created'
end