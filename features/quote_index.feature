@quoteindex
Feature: In order to find quotations and review outstanding quotations
					we want to be able to search and find by state.
					Finding by company is covered in the company views.

	Background:
		Given I have the following quotations to index
			|code | name | project | customer | issue_date | total | status |
			|SQ01 | 1order1 | P001 | CompanyA | 2013-05-01 | 1000 | open |
			|SQ02 | 2order2 | P002 | CompanyB | 2013-05-02 | 1000 | issued |
			|SQ03 | 3order3 | P003 | CompanyA | 2013-05-03 | 1000 | open |
			|SQ04 | 4order4 | P004 | CompanyB | 2013-05-04 | 1000 | open |
			And I am logged in as a user with a role "sales_quote"
			And I visit "/quotations/"

	Scenario: The index page has the required columns for open quotations
		Then I should see "SQ01"
		And I should see "1order1"
		And I should see "P001"
		And I should see "CompanyA"
		And I should see "2013-05-01"
		And I should see "£1,000"
		And I should see "open"

	Scenario: I can search for sales quotations by name
		When I fill_in search box with "3o"
		And I submit the "quotations_search" form
		Then I should see "3order3"
		And I should not see "1order1"
		