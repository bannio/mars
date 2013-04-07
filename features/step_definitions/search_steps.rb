Given(/^I have the following companies$/) do |table|
  table.hashes.each do |attributes|
    Company.create!(attributes)
  end
end

Then(/^I should see a search input field$/) do
  page.should have_selector('input#search')
end

When(/^I type "(.*?)" into the "(.*?)" field$/) do |content, field|
  fill_in(field, with: content)
end

Then(/^I should see the companies in this order:$/) do |table|
  expected_order = table.raw.flatten
  actual_order = page.all('td:first-child').collect(&:text)
  actual_order.should ==  expected_order
end

When(/^I submit with enter$/) do
  click_on('Search')
end