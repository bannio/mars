@search_projects @selenium
Feature: Search
	In order to make finding a project easier
	as a user I expect the projects to be sorted by code 
	and I want a search utility by name

	Background:
		Given I have the following companies
			|name|
			|Z Company|
			|G Company|
			|A Company|
		And I have the following projects
			| code |name| company |
			| P003 |Third project |Z Company |
			| P002 |Second project |G Company |
			| P001 |First project | G Company |
		And I am logged in as a user with a role "project"
		And I am on the "projects" page
		
	Scenario: Projects are sorted by code ascending
		Then I should see the projects in this order:
			| P001  |
			| P002  |
			| P003  |
			
	Scenario: I can search by project name
		Then I should see a search input field
		When I type "Th" into the "search" field
		And I submit with enter
		Then I should see "P003"
		And I should not see "P001"
		And I should not see "P002"

	Scenario: the search is not case sensitive
		When I type "th" into the "search" field
		And I submit with enter
		Then I should see "P003"
		And I should not see "P001"

	Scenario: I can select a project from the search set by clicking on the row
		When I type "th" into the "search" field
		And I submit with enter
		Then I should see "P003"
		When I click on the "P003" row
		Then I should be on the "P003" show page