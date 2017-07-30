@javascript @search @selenium

Feature: Search
	In order to make finding a company easier
	as a user I expect the companies to be sorted by name
	and I want a search utility

	Background:
		Given I have the following companies
			|name|
			|Z Company|
			|G Company|
			|A Company|
		And I am logged in as a user with a role "company"
		And I am on the "companies" page

	Scenario: Companies are sorted by name ascending
		Then I should see the companies in this order:
			| A Company |
			| G Company |
			| Z Company |

	Scenario: I can search by company name
		Then I should see a search input field
		When I type "G Com" into the "search" field
		And I submit with enter
		Then I should see "G Company"
		And I should not see "A Company"
		And I should not see "Z Company"

	Scenario: the search is not case sensitive
		When I type "g com" into the "search" field
		And I submit with enter
		Then I should see "G Company"
		And I should not see "A Company"