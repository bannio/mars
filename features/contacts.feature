@contacts
Feature: Contacts
	In order to be able to communicate effectively with suppliers and customers
	the system needs to hold contact details. A contact belongs to a company.
	
	Background:
		Given I am logged in as a user with a role "company"
		
	Scenario: There is a Contacts menu option
		Then I should see "Contacts" as a menu option
		When I click "Contacts"
		Then I should see a list of contacts
		
	Scenario: Add a new contact as an authorised user
		Given the company "MyCompany" exists
		And the address "MyCompany" exists
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
	
	Scenario: A user without the "company" role cannot access contacts
		Given I am not logged in
		When I log in as a non-admin user
		Then I should not see "Contacts" as a menu option
		And if I try to visit the contacts page
		Then I should see "Not authorised"