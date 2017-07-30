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

Then(/^I should see the (.*?) in this order:$/) do |name, table|
  expected_order = table.raw.flatten
  actual_order = page.all('td:first-child').collect(&:text)
  actual_order.should ==  expected_order
end

When(/^I submit with enter$/) do
  # click_button "Search"
  find('.search-query').native.send_keys(:return)
end

When(/^I click on the "(.*?)" row$/) do |arg1|
  # For some reason the click event is not being added
  # during test run so adding it back here
  page.execute_script("$('tr.rowlink').click(function() {
    return window.location = $(this).data('rowlink');});")

  # find(:xpath, "//tr/td[.='#{arg1}']").click
  find('td', text: "#{arg1}").click
end

# This is a project specific step:
Then(/^I should be on the "(.*?)" show page$/) do |arg1|
  project_id = Project.find_by_code(arg1).id
  # visit show_project_path(project)
  expect(page).to have_current_path("/projects/#{project_id}")
end