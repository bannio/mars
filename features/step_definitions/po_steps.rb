When(/^I select PO contact "(.*?)"$/) do |contact|
  select( contact, from: 'Contact' )
end

When(/^I select PO client "(.*?)"$/) do |client|
  select( client, from: 'Client')
end

Given(/^I have setup a PO$/) do
	steps %{
		When I click "New Purchase Order"
		When I select customer "Elderberry"
		And I select PO client "Client"
		And I select supplier "Z Company"
		And I click button "Next"
	}
end

Given(/^I select Supplier contact "(.*?)"$/) do |contact|
  select(contact, from: 'Supplier Contact')
end

Given(/^I select Supplier address "(.*?)"$/) do |addr|
  select(addr, from: 'Supplier address')
end

Given(/^I select Delivery address "(.*?)"$/) do |addr|
  select(addr, from: 'Delivery address')
end

And(/^I have completed the PO header$/) do
	steps %{
		And I select project "My project"
		And I fill in "Title" with "My PO"
    And I fill in "Due date" with "2013-05-20"
		And I select Supplier contact "Fred"
		And I select Supplier address "primary"
		And I select Delivery address "client address"
		And I click button "Create Purchase order"
	}
end

Then(/^when I enter the following po line detail$/) do |table|
  table.hashes.each do |row|
    fill_in('purchase_order_purchase_order_lines_attributes_0_name', with: row[:name])
    fill_in('purchase_order_purchase_order_lines_attributes_0_description', with: row[:description])
    fill_in('purchase_order_purchase_order_lines_attributes_0_quantity', with: row[:quantity])
    fill_in('purchase_order_purchase_order_lines_attributes_0_unit_price', with: row[:unit_price])
  end
end

Then(/^I should see (.\d,?\d*\.\d{2}) in the po header table$/) do |value|
  within("table#po-header-table"){page.should have_content(value)}
end

Then(/^I should see (.\d,?\d*\.\d{2}) in the po detail table$/) do |value|
  within("table#po-detail-table"){page.should have_content(value)}
end

Given(/^I have the following purchase orders to index$/) do |table|
  table.hashes.each do |r|
  	@customer = FactoryGirl.create(:company, name: r[:customer]) unless Company.find_by_name(r[:customer])
    @client = FactoryGirl.create(:company, name: r[:client])
    @supplier = FactoryGirl.create(:company, name: r[:supplier]) unless Company.find_by_name(r[:supplier])
    @project = FactoryGirl.create(:project, code: r[:project], company_id: @client.id)
    @contact = FactoryGirl.create(:contact)
    @purchase_order = FactoryGirl.create(:purchase_order, code: r[:code], 
                                    customer: @customer, issue_date: r[:issue_date],
                                    client: @client, contact: @contact,
                                    name: r[:name], project: @project,
                                    supplier: @supplier,
                                    status: r[:status], due_date: r[:due_date])
    purchase_order_lines = FactoryGirl.create(:purchase_order_line, purchase_order_id: @purchase_order.id,
                                    unit_price: r[:total])
  end
end





