
When(/^I select customer "(.*?)"$/) do |customer|
  select( customer, from: 'Customer' )
end

When(/^I select project "(.*?)"$/) do |project|
  select( project, from: 'Project' )
end

When(/^I select supplier "(.*?)"$/) do |supplier|
  select( supplier, from: 'Supplier' )
end

When(/^I click button "(.*?)"$/) do |target|
  click_button "#{target}"
end

Given(/^I visit the (.*?) company page$/) do |arg1|
  @company = Company.find_by_name(arg1)
  id = @company.id
  visit "/companies/#{id}"
end

And(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, with: value)
end

Then(/^when I enter the following detail$/) do |table|
  table.hashes.each do |row|
    fill_in('quotation_quotation_lines_attributes_0_name', with: row[:name])
    fill_in('quotation_quotation_lines_attributes_0_description', with: row[:description])
    fill_in('quotation_quotation_lines_attributes_0_quantity', with: row[:quantity])
    fill_in('quotation_quotation_lines_attributes_0_unit_price', with: row[:unit_price])
  end
end

Then(/^I should see (.\d,?\d*\.\d{2}) in the header table$/) do |value|
  within("table#sq-header-table"){page.should have_content(value)}
end

Then(/^I should see (.\d,?\d*\.\d{2}) in the detail table$/) do |value|
  within("table#sq-detail-table"){page.should have_content(value)}
end

When(/^I select the file "(.*?)"$/) do |file|
  attach_file 'file', file
end

Then(/^I should see a successfully imported message$/) do
  page.should have_content('successfully imported')
end