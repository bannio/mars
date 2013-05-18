
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

Given(/^I have the following project quotations$/) do |table|
  table.hashes.each do |r|
    customer = Company.find_by_name(r[:customer])
    project = Project.find_by_code(r[:project])
    quotation = FactoryGirl.create(:quotation, code: r[:code], 
                                    customer: customer, issue_date: r[:issue_date],
                                    name: r[:name], project: project,
                                    status: r[:status])
    quotation_lines = FactoryGirl.create(:quotation_line, quotation_id: quotation.id,
                                    unit_price: r[:total])
  end
end

Given(/^I have the following project sales orders$/) do |table|
  table.hashes.each do |r|
    customer = Company.find_by_name(r[:customer])
    project = Project.find_by_code(r[:project])
    sales_order = FactoryGirl.create(:sales_order, code: r[:code], 
                                    customer: customer, issue_date: r[:issue_date],
                                    name: r[:name], project: project,
                                    status: r[:status])
    sales_order_lines = FactoryGirl.create(:sales_order_line, sales_order_id: sales_order.id,
                                    unit_price: r[:total])
  end
end

And(/^I visit project "(.*?)"$/) do |project|
  id = Project.find_by_code(project).id
  visit project_path(id)
end

Given(/^I am on the "(.*?)" project page$/) do |name|
  visit project_path(Project.find_by_name(name).id)
end