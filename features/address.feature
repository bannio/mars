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
		Given I am on the Company page for "Company X"
		When  I click on "New" against "Addresses"
		Then I can create a new address for "Company X"
		And I should see a successfully created message
		
	Scenario: Edit an existing address
		Given I am on the "addresses/index" page
		When I click "Edit"
		Then I can change the address
		And I should see a successfully updated message
	
	Scenario: A user without the "company" role cannot edit addresses
		Given I am not logged in
		When I log in as a non-admin user
		And I am on the "addresses/index" page
		Then I should not see "Edit"
		And if I try by editing the url to "/companies/1/addresses/1/edit"
		Then I should see "Not authorised"