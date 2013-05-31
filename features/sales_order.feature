@sales
Feature: In order to sell to companies I need to be able to issue sales orders.

	Background:
		Given I have the following companies
			|name|
			|Elderberry|
			|Z Company|
		And "Elderberry" has an address

		And I have the following projects
			| code |name| company | status |
			| P001 |My project |Z Company | open |
		And I have the following contacts
	      | name | email | company |
	      | Fred | fred@example.com | Z Company |
		And I am logged in as a user with a role "sales_order"
		And I visit the Z Company company page
		
	Scenario: I can create a new sales order
		When I click "New Sales Order"
		Then I should be on the "New sales order" page
		When I select supplier "Elderberry"
		And I select project "My project"
		And I fill in "Title" with "Test Quote"
		And I select sales_order contact "Fred"

		And I click button "Create Sales order"
		Then I should see a successfully created message
		And I should be on the "Sales Order for" page
		
	Scenario: Add lines to a sales_order
		When I click "New Sales Order"
		And I select supplier "Elderberry"
		And I select project "My project"
		And I fill in "Title" with "Test Quote"
		And I select sales_order contact "Fred"
		And I click button "Create Sales order"
		Then I should be on the "Sales Order for" page
		And when I enter the following sales line detail
			|name|description|quantity|unit_price|
			|chair|office chair |2|120.25|
		And I click button "Add"
		Then I should be on the "Sales Order for" page
		Then I should see £240.50 in the header table
		And I should see £240.50 in the so detail table
		
	Scenario: Remove lines from a Sales Order
		Given I have the following sales orders
		  | code | name | customer | supplier | project | contact | 
		  | SO001 | Test SO | Z Company | Elderberry | P001 | Fred | 
		And I visit the sales order page for "SO001"
		And when I enter the following sales line detail
			|name|description|quantity|unit_price|
			|chair|office chair |2|120.25|
		And I click button "Add"
		Then I should see £240.50 in the header table
		When  I click "Remove"
		Then I should be on the "Sales Order for" page
		Then I should see £0.00 in the header table
		 
	Scenario: Issue Sales Order
		Given I have the following sales orders
		  | code | name | customer | supplier | project | contact | 
		  | SO001 | Test SO | Z Company | Elderberry | P001 | Fred | 
		And I visit the sales order page for "SO001"
		And when I enter the following sales line detail
			|name|description|quantity|unit_price|
			|chair|office chair |2|120.25|
		And I click button "Add"
		Then the sales order "SO001" state is "open"
		When  I click "Issue Sales Order"
		Then I should be on the email page
		And the sales order "SO001" state is "issued"
	