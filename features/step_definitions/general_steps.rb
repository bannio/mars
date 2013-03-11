Given(/^I visit the home page$/) do
  visit '/'
end

Then(/^I should see "(.*?)"$/) do |arg1|
  page.has_content?(arg1).should be_true
end