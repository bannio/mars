@quote
Feature: In order to sell to companies I need to be able to issue sales quotations.

	Background:
		Given I have the following companies
			|name|
			|Z Company|
		And I have the following projects
			| code |name| company |
			| P001 |My project |Z Company |
		And I am logged in as a user with a role "sales_quote"
		And I am on the "quotations" page
		
	Scenario: I can create a new quotation
		When I click "New Quotation"
		Then I am on the "New Quotation" page
		When I select "company Z"
		And I click "Create Quotation"
		Then I should see a successfully created message