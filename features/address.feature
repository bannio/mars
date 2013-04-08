@address
Feature: Addresses
	In order to be able to communicate effectively with suppliers and customers
	the system needs to hold addresses. These are managed within Companies
	
	Background:
		Given I am logged in as a user with a role "company"
		And the company "MyCompany" exists
		And the address "MyCompany Address" exists
		
	Scenario: Add a new address as an authorised user
		Given I am on the Company page for "Company X"
		When  I click on "New" against "Addresses"
		Then I can create a new address for "Company X"
		And I should see a successfully created message
		
	Scenario: Edit an existing address
		Given I am on the Company page for "Company X"
		When  I click on "New" against "Addresses"
		Then I can create a new address for "Company X"
		When  I click on Edit against the address
		Then I can change the address
		And I should see a successfully updated message
	
	Scenario: A user without the "company" role cannot edit addresses
		Given I am not logged in
		When I log in as a non-admin user
		And I am on the Company page for "Company X"
		Then I should not see "Edit" against the address
		And if I try by editing the url to "/companies/1/addresses/1/edit"
		Then I should see "Not authorised"