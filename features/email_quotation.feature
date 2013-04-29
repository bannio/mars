@email
Feature: Email quotations (and other documents)
	In order to be able track communications with customers
	I want the system to accept email details and send quotations
	as attachments whilst logging this activity.
	
	Background:
		Given I have the following companies
	      | name       |
	      | A Company  |
	      | Elderberry |
	    And I have the following projects
	      | code | name       | company   |
	      | P001 | My project | A Company |
		And I have the following quotations
		  | code | name | customer | supplier | project |
		  | SQ001 | Test SQ | A Company | Elderberry | P001 |
		And the quotation has the following lines
		  | code | name | description | quantity | unit_price |
		  | SQ001 | chair | office chair | 10 | 220.50 |
		And I am logged in as a user with a role "sales_quote"
		And I am on the show page for quotation SQ001
	
	Scenario: Issue a Sales Quotation takes me to an email page
		When I click "Issue Quotation"
		Then I should be on the email page