@quote
Feature: In order to sell to companies I need to be able to issue sales quotations.

	Background:
		Given I have the following companies
			|name|
			|Z Company|
			|Elderberry|
		And I have the following projects
			| code |name| company |
			| P001 |My project |Z Company |
		And I am logged in as a user with a role "sales_quote"
		And I visit the Z Company company page
		
	Scenario: I can create a new quotation
		When I click "New Quotation"
		Then I should be on the "New quotation" page
		When I select supplier "Elderberry"
		And I select project "My project"
		And I fill in "Title" with "Test Quote"
		And I click button "Create Quotation"
		Then I should see a successfully created message
		And I should be on the "Sales Quotation for" page
		
	Scenario: Add lines to a quotation
		When I click "New Quotation"
		And I select supplier "Elderberry"
		And I select project "My project"
		And I fill in "Title" with "Test Quote"
		And I click button "Create Quotation"
		Then I should be on the "Sales Quotation for" page
		And when I enter the following detail
			|name|description|quantity|unit_price|
			|chair|office chair |2|120.25|
		And I click button "Add"
		Then I should be on the "Sales Quotation for" page
		Then I should see £240.50 in the header table
		And I should see £240.50 in the detail table
		
	Scenario: Import lines from file
		When I click "New Quotation"
		And I select supplier "Elderberry"
		And I select project "My project"
		And I fill in "Title" with "Test Quote"
		And I click button "Create Quotation"
		Then I should be on the "Sales Quotation for" page
		When I select the file "spec/fixtures/testquotelines.csv"
		And I click button "Import"
		Then I should see a successfully imported message
		And I should see £3,373.15 in the header table
		
		