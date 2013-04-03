Then(/^I should see a list of companies$/) do
  page.should have_selector('h1#companies-index-page')
end

Then(/^I can create a new company$/) do
  fill_in('Name', with: 'New Company')
  fill_in('Accounts Reference', with: 'AB12')
  click_button 'Create Company'
end

Then(/^I can change the company$/) do
  fill_in('Name', with: 'New Name')
  click_button 'Update Company'
end

Given /^I click OK in popup$/ do 
  page.driver.browser.switch_to.alert.accept
end

Then(/^the company should be gone$/) do
  visit companies_path
  page.should_not have_content "MyCompany"
end

Given(/^I am on the Company page for "(.*?)"$/) do |company|
  @company = create_company(company)
  visit company_path(@company)
  page.should have_content(company)
end

Then(/^I should be on the Company page for "(.*?)"$/) do |company|
  within('h1'){page.should have_content('Company')}
  page.should have_content(company)
end

Given(/^the company "(.*?)" exists$/) do |company|
  create_company(company)
end