
Given(/^I have the following sales orders$/) do |table|
  table.hashes.each do |r|
    SalesOrder.create!(name: r[:name], 
                      code: r[:code],
                      customer_id: Company.find_by_name(r[:customer]).id,
                      supplier_id: Company.find_by_name(r[:supplier]).id,
                      project_id: Project.find_by_code(r[:project]).id,
                      contact_id: Contact.find_by_name(r[:contact]).id
                      )
  end
end

Then(/^when I enter the following sales line detail$/) do |table|
  table.hashes.each do |row|
    fill_in('sales_order_sales_order_lines_attributes_0_name', with: row[:name])
    fill_in('sales_order_sales_order_lines_attributes_0_description', with: row[:description])
    fill_in('sales_order_sales_order_lines_attributes_0_quantity', with: row[:quantity])
    fill_in('sales_order_sales_order_lines_attributes_0_unit_price', with: row[:unit_price])
  end
end

Given(/^I visit the sales order page for "(.*?)"$/) do |arg1|
  sales_order = SalesOrder.find_by_code(arg1)
  visit sales_order_path(sales_order)
end

Then(/^the sales order "(.*?)" state is "(.*?)"$/) do |sales_order,state|
  sales_order = SalesOrder.find_by_code(sales_order)
  expect(sales_order.current_state).to eq(state)
end

Given(/^I have an issued sales order "(.*?)" and visit that page$/) do |code|
  sales_order = FactoryGirl.create(:sales_order, code: code)
  event = FactoryGirl.create(:event, eventable_type: 'SalesOrder',
                          eventable_id: sales_order.id,
                          state: 'issued')
  visit sales_order_path(sales_order)
end

And (/^"(.*?)" has an address$/) do |name|
  address = FactoryGirl.create(:address, company_id: Company.find_by_name(name).id)
end

Given(/^I have the following sales orders to index$/) do |table|
  table.hashes.each do |r|
    customer = FactoryGirl.create(:customer, name: r[:customer])
    project = FactoryGirl.create(:project, code: r[:project], company_id: customer.id)
    sales_order = FactoryGirl.create(:sales_order, code: r[:code], 
                                    customer: customer, issue_date: r[:issue_date],
                                    name: r[:name], project: project)
    sales_order_lines = FactoryGirl.create(:sales_order_line, sales_order_id: sales_order.id, 
                                    unit_price: r[:total])
    event = FactoryGirl.create(:event, eventable_type: 'SalesOrder',
                          eventable_id: sales_order.id,
                          state: r[:state])
  end
end

Given(/^I visit "(.*?)"$/) do |path|
  visit path
end

When(/^I fill_in search box with "(.*?)"$/) do |search|
  fill_in('search', with: search)
end

And(/^I submit the "(.*?)" form$/) do |form_id|
  element = find_by_id(form_id)
    Capybara::RackTest::Form.new(page.driver, element.native).submit :name => nil
end

Then(/^I should see (.\d,?\d*\.\d{2}) in the so detail table$/) do |value|
  within("table#so-detail-table"){page.should have_content(value)}
end

