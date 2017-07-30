
When(/^I select customer "(.*?)"$/) do |customer|
  select( customer, from: 'Customer' )
end

When(/^I select project "(.*?)"$/) do |project|
  select( project, from: 'Project' )
end

When(/^I select supplier "(.*?)"$/) do |supplier|
  select( supplier, from: 'Supplier' )
end

When(/^I select sales_order contact "(.*?)"$/) do |contact|
  select( contact, from: 'sales_order[contact_id]' )
end

When(/^I select quotation contact "(.*?)"$/) do |contact|
  select( contact, from: 'quotation[contact_id]' )
end

Given(/^"(.*?)" has an address "([^"]*)"$/) do |company, address|
  company = Company.find_by_name(company)
  create(:address, name: address, company_id: company.id)
end

When(/^I select delivery address "(.*?)"$/) do |address|
  select( address, from: 'quotation[delivery_address_id]' )
end

When(/^I select contact address "(.*?)"$/) do |address|
  select( address, from: 'quotation[address_id]' )
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

Given(/^I have the following quotations to index$/) do |table|
  table.hashes.each do |r|
    customer = FactoryGirl.create(:customer, name: r[:customer])
    project = FactoryGirl.create(:project, code: r[:project], company_id: customer.id)
    quotation = FactoryGirl.create(:quotation, code: r[:code],
                                    customer: customer, issue_date: r[:issue_date],
                                    name: r[:name], project: project,
                                    status: r[:status])
    quotation_lines = FactoryGirl.create(:quotation_line, quotation_id: quotation.id,
                                    unit_price: r[:total])
  end
end


Then(/^I should see (.\d,?\d*\.\d{2}) in the header table$/) do |value|
  within("table#sq-header-table"){page.should have_content(value)}
end

Then(/^I should see (.\d,?\d*\.\d{2}) in the detail table$/) do |value|
  within("table#sortable-table"){page.should have_content(value)}
end

When(/^I select the file "(.*?)"$/) do |file|
  attach_file 'file', file
end

Then(/^I should see a successfully imported message$/) do
  page.should have_content('successfully imported')
end

Then(/^I should be on the quotation show page$/) do
  page.should have_selector('#quotation-show-page')
  # expect(current_path).to eq(quotation_path)  <- this won't work without a quotation id
end
