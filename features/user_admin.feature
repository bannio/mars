@user
Feature: User management
	As an administrator I need to be able to create and edit user accounts
	so that users have the appropriate access to system functions and data
		
	Background: I am logged in as an admin and select the User menu option
		Given I am logged in as an admin
		Then I should see "Users" as a menu option
		When I click "Users"
		Then I should see a list of users		
	
	Scenario: I can view user details
		When I click "Show"
		Then I should see "Name"
		And I should see "Email"
		And I should see "Roles"
		
	Scenario: I can edit user details
		When I click "Edit"
		Then I should be on the "Edit User" page
		And I should see "Name"
		And I should see "Email"
		And I should see "Password"
		And I should see "Password confirmation"
		And I should see "Roles"
		And there should be an "Update User" button
		
	Scenario: I can save changes to a users details
		Given there is a user to edit
		And I click the first "Edit" link
		And I make a valid change to the password fields
		Then I should see a successful change message
		And I should be on the "green" page

	Scenario: I cannot list users as a non-admin
		Given I am not logged in
		When I log in as a non-admin user
		Then I should not see "Users" as a menu option	