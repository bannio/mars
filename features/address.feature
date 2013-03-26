@address
Feature: Addresses
	In order to be able to communicate effectively with suppliers and customers
	the system needs to hold addresses.
	
	Scenario: There is an Addresses menu option
		Given I am logged in as a user with a role "company"
		Then I should see "Addresses" as a menu option
		When I click "Addresses"
		Then I should see a list of addresses  
		
	Scenario: Add a new address as an authorised user
		Given I am logged in as a user with a role "company"
		And the company "MyCompany" exists
		When I click "Addresses"
		And I click "New Address"
		Then I can create a new address for "MyCompany"
		And I should see a successfully created message
		
	Scenario: Edit an existing address
	
	Scenario: Delete an address