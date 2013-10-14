@projectshow
Feature: To help manage the projects I want to be able to see running totals
					of the spend in quotations and orders at different stages

	Background:
		Given the company "A Company" exists
		Given I have the following projects
			|name | code | company | status |
			|Project1 | P001 | A Company | open |
		And I have the following project quotations
			|code | name | project | customer | issue_date | total | status |
			|SQ01 | 1order1 | P001 | A Company | 2013-05-01 | 1000 | open |
			|SQ02 | 2order2 | P001 | A Company | 2013-05-02 | 1000 | issued |
			|SQ03 | 3order3 | P001 | A Company | 2013-05-03 | 1000 | open |
			|SQ04 | 4order4 | P001 | A Company | 2013-05-04 | 1000 | open |

		And I have the following project sales orders
			|code | name | project | customer | issue_date | total | status |
			|SO01 | 1order1 | P001 | A Company | 2013-05-01 | 500  | open |
			|SO02 | 2order2 | P001 | A Company | 2013-05-02 | 1000 | issued |
			|SO03 | 3order3 | P001 | A Company | 2013-05-03 | 1500 | accepted |
			|SO04 | 4order4 | P001 | A Company | 2013-05-04 | 2000 | invoiced |
		And I am logged in as a user with a role "project"
		And I visit project "P001"

	Scenario: Totals are displayed
		Then I should see "Open £3,000.00 £500.00"
		And I should see "Issued £1,000.00 £1,000.00"
		And I should see "Total £4,000.00 £5,000.00"