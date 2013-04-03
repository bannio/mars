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

Then(/^I should not see "(.*?)"$/) do |arg1|
  page.has_content?(arg1).should_not be_true
end

Given(/^I am logged in as a user with a role "(.*?)"$/) do |role|
  create_company_user if role == 'company'
  sign_in
end

Then(/^I should see a successfully created message$/) do
  page.should have_content 'was successfully created'
end

Given(/^I am on the "(.*?)" page$/) do |arg1|
  visit "/#{arg1}"
end

Then(/^I should see a successfully updated message$/) do
  page.should have_content 'was successfully updated'
end

Then(/^if I try to visit the (.*?) page$/) do |page|
  visit "/#{page}"
end

When(/^if I try by editing the url to "(.*?)"$/) do |url|
  visit "#{url}"
end

