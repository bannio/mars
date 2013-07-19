Given(/^I have the following quotations$/) do |table|
  table.hashes.each do |r|
    Quotation.create!(name: r[:name], 
                      code: r[:code],
                      customer_id: Company.find_by_name(r[:customer]).id,
                      supplier_id: Company.find_by_name(r[:supplier]).id,
                      project_id: Project.find_by_code(r[:project]).id,
                      contact_id: Contact.find_by_name(r[:contact]).id,
                      status: 'open'
                      )
  end
end

Given(/^I have the following addresses$/) do |table|
  table.hashes.each do |r|
    Address.create!(name: r[:name], 
                    body: r[:body],
                    post_code: r[:post_code],
                    company_id: Company.find_by_name(r[:company]).id
                    )
  end
end

Given(/^the status is "(.*?)"$/) do |status|
  @quotation.update_attributes(status: status)
  @quotation.current_state.should == status
end

# Note poor quality of tests here. @quotation is a dependency for other steps
# but all steps should be independent
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

And(/^(.*?) has no email$/) do |contact|
  Contact.find_by_name(contact).update_attributes!(email: '')
end

When(/^I complete the email fields$/) do
  select('Fred', from: 'To')
end

And(/^the email should be delivered to (.*?)$/) do |email|
  # this doesn't work because cucumber doesn't know about mailer_macros.rb :(
  last_email.should include(email)
end