Then(/^I should see a list of addresses$/) do
  page.should have_selector('h1#addresses-index-page')
end

Then(/^I can create a new address for "(.*?)"$/) do |company|
  # select(company, from: 'Company')
  fill_in('Name', with: 'My address')
  click_button('Create Address')
end

Given(/^the address "(.*?)" exists$/) do |name|
  create_address(name)
end

Then(/^I can change the address$/) do
  fill_in('Address', with: "new address")
  click_button('Update Address')
end

When (/^I click on "New" against "Addresses"$/) do
  click_link('new-address')
end

When (/^I click on Edit against the address$/) do
  # works when there is an address present
  within("tr:nth-child(4) td:nth-child(4)") do
    click_link("Edit")
  end
end

Then(/^I should not see "(.*?)" against the address$/) do |arg1|
  within("tr:nth-child(4) td:nth-child(4)") do
    page.should_not have_content("Edit")
  end
end