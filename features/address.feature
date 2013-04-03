@address
Feature: Addresses
	In order to be able to communicate effectively with suppliers and customers
	the system needs to hold addresses.
	
	Background:
		Given I am logged in as a user with a role "company"
		And the company "MyCompany" exists
		And the address "MyCompany Address" exists
		
	Scenario: There is an Addresses menu option
		Then I should see "Addresses" as a menu option
		When I click "Addresses"
		Then I should see a list of addresses
		
	Scenario: Add a new address as an authorised user
		When I click "Addresses"
		And I click "New Address"
		Then I can create a new address for "MyCompany"
		And I should see a successfully created message
		
	Scenario: Edit an existing address
		Given I am on the "addresses" page
		When I click "Edit"
		Then I can change the address
		And I should see a successfully updated message
	
	Scenario: A user without the "company" role cannot edit addresses
		Given I am not logged in
		When I log in as a non-admin user
		And I am on the "addresses" page
		When I click "Edit"
		Then I should see "Not authorised"