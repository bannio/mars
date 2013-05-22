@po
Feature: Purchase Orders
	In order to buy things I need to be able to create purchase orders

	Background:
		Given I have the following companies
			|name|
			|Z Company|
			|Elderberry|
			|Client |
		And I have the following addresses
			|company|name | body | postcode |
			|Z Company| primary | Z House | ABC123 |
			|Elderberry| Watershed | our house | XYZ321 |
			|Client | client address | office | GFD 2AB |
		And I have the following projects
			| code |name| company | status |
			| P001 |My project |Client | open |
		And I have the following contacts
	      | name | email | company |
	      | Fred | fred@example.com | Z Company |
		And I am logged in as a user with a role "purchase"
		And I visit the Z Company company page

	Scenario: I can setup a new PO
		When I click "New Purchase Order"
		Then I should be on the "New Purchase Order" page
		When I select customer "Elderberry"
		And I select PO client "Client"
		And I select supplier "Z Company"
		And I click button "Next"
		Then I should see "Project"

	Scenario: Complete New PO
		Given I have setup a PO
		And  I select project "My project"

