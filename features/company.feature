@company
Feature: Company
 	In order to record orders and track projects against customers and suppliers
	the system needs to hold company records.
	
	Background:
		Given I am logged in as a user with a role "company"
		And the company "MyCompany" exists
		And the address "MyCompany Address" exists
		
	Scenario: I can see a Company menu item
		Then I should see "Companies" as a menu option
		When I click "Companies"
		Then I should see a list of companies
		
	Scenario: I cannot see a Company menu when not authorised
		Given I am not logged in
		When I log in as a non-admin user
		Then I should not see "Companies" as a menu option
		And if I try to visit the companies page
		Then I should see "Not authorised"
		
	Scenario: Add a new company as an authorised user
		When I click "Companies"
		And I click "New Company"
		Then I can create a new company
		And I should see a successfully created message

	Scenario: Edit an existing company
		Given I am on the "companies" page
		When I click "Edit"
		Then I can change the company
		And I should see a successfully updated message
		
	@javascript
	Scenario: Delete a company
		Given I am on the "companies" page
		When I click "Destroy"
		And I click OK in popup
		Then the company should be gone