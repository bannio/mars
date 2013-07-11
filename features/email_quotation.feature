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
	    And I have the following addresses
	      | company | name | body | post_code |
	      | Elderberry | primary | The Watershed | SO1 23 |
	    And I have the following projects
	      | code | name       | company   |
	      | P001 | My project | A Company |
	    And I have the following contacts
	      | name | email | company |
	      | Fred | fred@example.com | A Company |
		And I have the following quotations
		  | code | name | customer | supplier | project | contact |
		  | SQ001 | Test SQ | A Company | Elderberry | P001 | Fred |
		And the quotation has the following lines
		  | code | name | description | quantity | unit_price |
		  | SQ001 | chair | office chair | 10 | 220.50 |
		And I am logged in as a user with a role "sales_quote"
		And I am on the show page for quotation SQ001
	
	Scenario: Issue a Sales Quotation takes me to an email page
		When I click "Issue Quotation"
		Then I should be on the email page

	Scenario: I can issue a Sales Quotation without sending by email
		When I click "Issue Quotation"
		Then I should see "Cancel"
		And I click "Cancel"
		Then I should be on the quotation show page

	Scenario: I can send an email
		When I click "Issue Quotation"
		And I complete the email fields
		And I click button "Send Email"
		Then I should be on the quotation show page
		And I should see "Email was successfully created." 