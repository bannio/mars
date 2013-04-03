@contacts
Feature: Contacts
	In order to be able to communicate effectively with suppliers and customers
	the system needs to hold contact details. A contact belongs to a company.
	
	Background:
		Given I am logged in as a user with a role "company"
		Given the company "MyCompany" exists
		And the address "MyCompany" exists
		
	Scenario: There is a Contacts menu option
		Then I should see "Contacts" as a menu option
		When I click "Contacts"
		Then I should see a list of contacts
		
	Scenario: Add a new contact as an authorised user
		When I click "Contacts"
		And I click "New Contact"
		Then I can create a new contact for "MyCompany"
		And I should see a successfully created message
		
	Scenario: Edit an existing contact
		Given the contact "MyContact" exists
		And I am on the "contacts" page
		When I click "Edit"
		Then I can change the contact
		And I should see a successfully updated message
	
	Scenario: A user without the "company" role cannot edit contacts
		Given I am not logged in
		When I log in as a non-admin user
		Given the contact "MyContact" exists
		And I am on the "contacts" page
		When I click "Edit"
		Then I should see "Not authorised"
		
	Scenario: When I come from a Company page then I return to that page
		Given I am on the Company page for "Company X"
		When  I click on "New" against "Contacts"
		And I can create a new contact for "Company X"
		Then I should be on the Company page for "Company X"