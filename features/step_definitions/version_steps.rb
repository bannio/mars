Given(/^I have the following quotations$/) do |table|
  table.hashes.each do |r|
    Quotation.create!(name: r[:name], 
                      code: r[:code],
                      customer_id: Company.find_by_name(r[:customer]).id,
                      supplier_id: Company.find_by_name(r[:supplier]).id,
                      project_id: Project.find_by_code(r[:project]).id
                      )
  end
end

Given(/^the status is "(.*?)"$/) do |status|
  @quotation.events.create!(state: status, user_id: 1)
  @quotation.current_state.should == status
end

Given(/^I am on the show page for quotation (.*?\d+)$/) do |quote|
  @quotation = Quotation.find_by_code(quote)
  # id = @quotation.id
  #   visit "quotations/#{id}"
  visit quotation_path(@quotation)
end

Given(/^I add a line to the quotation$/) do
  fill_in("item", with: 'chair')
  fill_in('specification', with: 'swivel')
  fill_in('quantity', with: 1)
  fill_in('unit price', with: 120)
  click_button('Add')
end