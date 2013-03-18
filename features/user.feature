@user
Feature: User management and access
	In order to provide security and control
	MARS requires users to be defined, authenticated and authorized
	
	Scenario: Welcome Page
		Given I visit the home page
		And I am not logged in
		Then I should see "Login"
	
	Scenario: User is not signed up
      Given I do not exist as a user
      When I sign in with valid credentials
      Then I see an invalid login message
      And I should be signed out

    Scenario: User signs in successfully
      Given I exist as a user
      And I am not logged in
      When I sign in with valid credentials
      Then I see a successful sign in message
      When I return to the site
      Then I should be signed in

    Scenario: User enters wrong name
      Given I exist as a user
      And I am not logged in
      When I sign in with a wrong name
      Then I see an invalid login message
      And I should be signed out

    Scenario: User enters wrong password
      Given I exist as a user
      And I am not logged in
      When I sign in with a wrong password
      Then I see an invalid login message
      And I should be signed out

    Scenario: User signs out
      Given I am logged in
      When I sign out
      Then I should see a signed out message
      When I return to the site
      Then I should be signed out

	Scenario: I sign in and edit my account
      Given I am logged in
      When I edit my account details
      Then I should see an account edited message
