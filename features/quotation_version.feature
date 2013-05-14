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
		And I have the following contacts
		  | company   | name | email |
		  | A Company | Fred | fred@example.com |
		And I have the following addresses
		  | company | name | body | post_code |
		  | Elderberry | primary | The Watershed | SO20 8EW |
		  | A Company  | primary | The factory   | AA12 3BB |
	    And I have the following projects
	      | code | name       | company   |
	      | P001 | My project | A Company |
		And I have the following quotations
		  | code | name | customer | supplier | project | contact | 
		  | SQ001 | Test SQ | A Company | Elderberry | P001 | Fred | 
		And I am logged in as a user with a role "sales_quote"
		And I am on the show page for quotation SQ001
	
	Scenario: Issue quotation with no email
		Given the status is "open"
		And I add a line to the quotation
		When I click "Issue Quotation"
		And I click "Issue without Email"
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
		
	Scenario: Can issue a quotation without a contact email
		Given the status is "open"
		And Fred has no email
		And I add a line to the quotation
		When I click "Issue Quotation"
		And I click "Issue without Email"
		Then I should not see "There must be a contact with an email address to issue to"
		And I should see "Status issued"
	
	Scenario: Issue quotation with email
		Given the status is "open"
		And I add a line to the quotation
		When I click "Issue Quotation"
		And I complete the email fields
		And I click button "Create Email"
		Then I should see "Status issued"
		And I should not see "Issue Quotation"
		And I should see "Re-open"