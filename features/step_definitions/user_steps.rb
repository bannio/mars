### UTILITY METHODS ###

def create_visitor
  @visitor ||= { :name => 'visitor',:email => "example@example.com",
    :password => "please12", :password_confirmation => "please12" }
end

def find_user
  @user ||= User.where(:name => @visitor[:name]).first
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/users/sign_out'
end

def create_spare_user
  FactoryGirl.create(:user, name: 'Alpha', email: 'alpha@example.com')
end
def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, name: @visitor[:name], email: @visitor[:email])
end

def create_admin_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, name: @visitor[:name], email: @visitor[:email], roles_mask: 1)
end

def delete_user
  @user ||= User.where(:email => @visitor[:email]).first
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_name", :with => @visitor[:name]
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_name", :with => @visitor[:name]
  fill_in "user_password", :with => @visitor[:password]
  click_button "Login"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

When(/^I log in as a non\-admin user$/) do
  create_user
  sign_in
end

Given /^I am logged in as an admin$/ do
  create_admin_user
  sign_in
end


Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/users/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "please123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong name$/ do
  @visitor = @visitor.merge(:name => "wrongname")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "Change Password"
  fill_in "user_email", :with => "newname@new.co.uk"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit '/'
end

When /^I click the first "(.*?)" link$/ do |link|
  first(:link, "#{link}").click
end

When(/^I click "(.*?)"$/) do |target|
  click_link "#{target}"
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then /^I should be signed out$/ do
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Logged in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "Welcome! You have signed up successfully."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Emailis invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Passwordcan't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Passworddoesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Passworddoesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Logged out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid name or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see my name$/ do
  create_user
  page.should have_content @user[:name]
end

Then(/^I should see "(.*?)" as a menu option$/) do |opt|
  page.should have_content(opt)
end

Then(/^I should not see "(.*?)" as a menu option$/) do |opt|
  page.should_not have_content(opt)
end

Then(/^I should see a list of users$/) do
  page.should have_content('Listing Users')
end

Then(/^I should be on the "(.*?)" page$/) do |content|
  page.should have_content(content)
end

Then(/^there should be an "(.*?)" button$/) do |button|
  page.should have_selector('input.btn')
  page.should have_button(button)
end

Then(/^I make a valid change to the password fields$/) do
  fill_in('user_password', with: 'secret12')
  fill_in('user_password_confirmation', with: 'secret12')
  click_button('Update User')
end

Then(/^I make an invalid change to the password fields$/) do
  fill_in('user_password', with: 'secret12')
  fill_in('user_password_confirmation', with: 'public12')
  click_button('Update User')
end

Then(/^I should see a successful change message$/) do
  page.should have_content "User was successfully updated."
end

Given(/^there is a user to edit$/) do
  create_spare_user
  click_link('Users')
end
