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
		And I select project "My project"
		And I fill in "Title" with "My PO"
		And I fill in "Due date" with "2013-05-20"
		And I select Supplier contact "Fred"
		And I select Supplier address "primary"
		And I select Delivery address "client address"
		And I click button "Create Purchase order"
		Then I should see a successfully created message

	Scenario: Issue a PO
		Given I have setup a PO
		And I have completed the PO header
		And when I enter the following po line detail
			|name|description|quantity|unit_price|
			|chair|office chair |2|120.25|
		And I click button "Add"
		Then I should be on the "Purchase Order for" page
		Then I should see £240.50 in the po header table
		And I should see £240.50 in the po detail table
		When I click "Issue Purchase Order"
		Then I should see "Email PurchaseOrder"
		And I click "Issue without Email"
		Then I should be on the "Purchase Order for" page
		And I should see "Status issued"
		And I should not see "Issue Purchase Order"

	Scenario: Attempt to issue a PO with no lines
		Given I have setup a PO
		And I have completed the PO header
		When I click "Issue Purchase Order"
		Then I should see "There are no lines on this order"

	Scenario: Import lines from file
		Given I have setup a PO
		And I have completed the PO header
		When I select the file "spec/fixtures/testquotelines.csv"
		And I click button "Import"
		Then I should see a successfully imported message
		And I should see £3,373.15 in the po header table

	Scenario: Remove lines
		Given I have setup a PO
		And I have completed the PO header
		When I select the file "spec/fixtures/testquotelines.csv"
		And I click button "Import"
		Then I should see a successfully imported message
		And I should see "Remove"
		When I click the first "Remove" link
    Then I should see a successfully deleted message

  Scenario: Import lines from sales order
  	Given I have setup a PO
		And I have completed the PO header
		Then I should see "Sales Order Lines"
		When I click "Sales Order Lines"
		Then I should be on the "Sales Order Lines for Project" page





