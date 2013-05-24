@poindex
Feature: List Purchase Orders
				In order to see the current purchase orders and manage 
				them, I want to be able to list, sort and search

	Background: 
		Given I have the following purchase orders to index
			| code |project | name |  client | customer | supplier | status | issue_date | total | due_date |
			| PO1 | P1 | PO one   | EClientCo | Elderberry | ASupplyCo | open | 2013-05-01 | 100 | 2013-06-01 |
			| PO2 | P2 | PO two   | DClientCo | Elderberry | BSupplyCo | issued | 2013-05-01 | 100 | 2013-06-01 |
			| PO3 | P3 | PO three | CClientCo | Elderberry | CSupplyCo | delivered | 2013-05-01 | 100 | 2013-06-01 |
			| PO4 | P4 | PO four | BClientCo | Elderberry | DSupplyCo | paid | 2013-05-01 | 100 | 2013-06-01 |
			| PO5 | P5 | PO five | AClientCo | Elderberry | ESupplyCo | open | 2013-05-01 | 100 | 2013-06-01 |
		And I am logged in as a user with a role "purchase" 
		And I visit "/purchase_orders/"

	Scenario: I can list current Purchase Orders
		Then I should see "PO1"
		And I should see "PO one"
		And I should see "P1"
		And I should see "ASupplyCo"
		And I should see "£100.00"
		And I should see "2013-06-01"
		And I should see "open"
		And I should not see "PO4"

	Scenario: I can search within title
		And I fill_in search box with "thre"
		And I submit the "purchase_orders_search" form
		Then I should see "PO3"
		And I should not see "PO1"
		And I should not see "PO5"

		