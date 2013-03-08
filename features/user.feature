Feature: User management and access
	In order to provide security and control
	MARS requires users to be defined, authenticated and authorized
	
	Scenario: Welcome Page
		Given I visit the home page
		Then I should see "Login"
		And I should be able to login
		
	