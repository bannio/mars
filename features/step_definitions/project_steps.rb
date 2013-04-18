
Then(/^I should see a list of projects$/) do
  page.should have_selector('h1#projects-index-page')  
end

Given(/^the project "(.*?)" exists$/) do |project|
  @project = FactoryGirl.create(:project, name: project, company_id: @company.id)
end

Then(/^I should be on the New Project page$/) do
  page.should have_selector('h1#new-project-page')
end

Then(/^I can create a new project$/) do
  fill_in('project_code', with: 'P1')
  fill_in('Name', with: 'New Project')
  select('MyCompany', from: 'Company')
  click_button 'Create Project'
end

Then(/^I can change the project$/) do
  fill_in('Name', with: 'New Name')
  click_button 'Update Project'
end

Given(/^I have the following projects$/) do |table|
  table.hashes.each do |r|
    Project.create!(name: r[:name], code: r[:code], company_id: Company.find_by_name(r[:company]).id)
  end
end

Then(/^I should see the code "(.*?)"$/) do |code|
  find_field('Code').value.should == code
end