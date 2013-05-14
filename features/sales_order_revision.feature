@revision
Feature: Sales Order Revisions
	In order to control the workflow and keep a history
	I want to be able to create new versions of issued sales orders
	and track their revision history
	
	Background:
	  Given I am logged in as a user with a role "sales_order"
		And I have an issued sales order "SO0001" and visit that page

	Scenario: I can create a new version
		When I click "Re-open"
		Then I should see "Sales order status changed to open"
		And I should see "Status open"
		And I should see "Issue Sales Order"
		And I should not see "Re-open"
		And I should see "SO0001R1"

	Scenario: Issued sales orders functions
		Then I should not see "Edit"
		And I should see "Email sales_order"
		And I should see "Re-open"
		And I should see "Accept"
		And I should see "Cancel"

	Scenario: Accepted sales order functions
		When I click "Accept"
		Then I should see "Status accepted"
		And I should see "Invoice"
		And I should not see "Cancel"
		And I should not see "Re-open"
		And I should not see "Email sales_order"

	Scenario: Invoiced sales order functions
		When I click "Accept"
		And I click "Invoice"
		Then I should see "Status invoiced"
		And I should not see "Cancel"
		And I should not see "Re-open"
		And I should not see "Email sales_order"
		And I should see "Paid"

	Scenario: Paid sales order functions
		When I click "Accept"
		And I click "Invoice"
		And I click "Paid"
		Then I should see "Status paid"
		And I should not see "Cancel"
		And I should not see "Re-open"
		And I should not see "Paid"
		And I should not see "Email sales_order"

	Scenario: Cancelled sales order functions
		When I click "Cancel"
		Then I should see "Status cancelled"
		And I should not see "Edit"
		And I should not see "Cancel"
		And I should not see "Re-open"
		And I should not see "Email sales_order"


