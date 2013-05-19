@project
Feature: Project
 	In order to record orders and track projects against customers and suppliers
	the system needs to hold project records.
	
	Background:
		Given I am logged in as a user with a role "project"
		And the company "MyCompany" exists
		And the project "MyProject" exists
		
	Scenario: I can see a Projects menu item
		Then I should see "Projects" as a menu option
		When I click "Projects"
		Then I should see a list of projects
		
	Scenario: Add a new project as an authorised user
		When I click "Projects"
		And I click the first "New Project" link
		Then I should be on the New Project page
		Then I can create a new project
		And I should see a successfully created message

	Scenario: Edit an existing project
		Given I am on the "MyProject" project page
		When I click "Edit"
		Then I can change the project
		And I should see a successfully updated message
		
	Scenario: I cannot edit a project when not authorised
		Given I am not logged in
		When I log in as a non-admin user
		And I am on the "MyProject" project page
		Then I should not see "Edit"
		And if I try by editing the url to "/projects/1/edit"
		Then I should see "Not authorised"
		
	Scenario: New projects are assigned a code
		Given I have the following companies
			|name|
			|Z Company|
			|G Company|
			|A Company|
		And I have the following projects
			| code |name| company |
			| P001 |Third project |Z Company |
			| P002 |Second project |G Company |
			| P003 |First project | G Company |
		And I am logged in as a user with a role "project"
		And I am on the "projects" page
		And I click the first "New Project" link
		Then I should see the code "P004"

	Scenario: I can close a project
		Given I am on the "MyProject" project page
		When I click "Close Project"
		Then I should see "Status closed"
		And I should not see "Close Project"
		