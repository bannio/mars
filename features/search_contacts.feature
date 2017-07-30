@search_contacts @javascript
Feature: Search
	In order to make finding a contact easier
	as a user I expect the contacts to be sorted by name
	and I want a search utility

	Background:
		Given I have the following companies
			|name|
			|Z Company|
			|G Company|
			|A Company|
		And I have the following contacts
			| name |email| company |
			| Adam |adam@example.com |Z Company |
			| Zach |zach@example.com |G Company |
			| Bob  |bob@example.com | G Company |
		And I am logged in as a user with a role "company"
		And I am on the "contacts/index" page

	Scenario: Contacts are sorted by contact name ascending
		Then I should see the contacts in this order:
			| Adam  |
			| Bob   |
			| Zach  |

	Scenario: I can search by contact name
		Then I should see a search input field
		When I type "Z" into the "search" field
		And I submit with enter
		Then I should see "Zach"
		And I should not see "Bob"
		And I should not see "Adam"

	Scenario: the search is not case sensitive
		When I type "z" into the "search" field
		And I submit with enter
		Then I should see "Zach"
		And I should not see "Bob"