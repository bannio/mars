@version
Feature: Version Control
	In order to control the workflow and keep a history
	I want to be able to change the status of any transaction 
	and to know who made the change and when
	
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
		And I am logged in as a user with a role "sales_quote"
		And I am on the show page for quotation SQ001
	
	Scenario: change sales quotation status from open to issued
		Given the status is "open"
		And I add a line to the quotation
		When I click "Issue Quotation"
		Then I should see "Quotation status changed to issued"
		And I should see "Status issued"
		And I should not see "Issue Quotation"
		And I should see "Re-open"
		
	Scenario: Cannot issue a quotation with no lines
		Given the status is "open"
		When I click "Issue Quotation"
		Then I should see "There are no lines on this quotation"
		And I should not see "Status issued"
		And I should see "Issue Quotation"
		And I should not see "Re-open"
		
	Scenario: reopen an issued quotation
		Given the status is "issued"
		And I am on the show page for quotation SQ001
		When I click "Re-open"
		Then I should see "Quotation status changed to open"
		And I should see "Status open"
		And I should see "Issue Quotation"
		And I should not see "Re-open"