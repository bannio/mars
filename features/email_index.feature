@emailindex
Feature: In order to find emails
					we want to be able to search and find by attachment.

	Background:
		Given I have the following emails
			|type | from | to | attachment | date | body |
			|Quotation | owen@example.com | customer@example.com | SQ001.pdf | 2013-05-01 | email one body |
			|Quotation | owen@example.com | customer@example.com | SQ002.pdf | 2013-05-01 | email two body |
			|SalesOrder | owen@example.com | customer@example.com | SO002.pdf | 2013-05-01 | email three |
			|SalesOrder | owen@example.com | customer@example.com | SO001.pdf | 2013-05-01 | email four body |

			And I am logged in as a user with a role "sales_order"
			And I visit "/emails/"

	Scenario: The index page has the required columns
		Then I should see "Type"
		And I should see "From"
		And I should see "To"
		And I should see "Attachment"
		And I should see "Date"

	Scenario: I can search for emails by attachment
		When I fill_in search box with "SQ001"
		And I submit the "emails_search" form
		Then I should see "SQ001.pdf"
		And I should not see "SQ002.pdf"

	Scenario: I can view the details
		When I am on the "emails/1" page
		Then I should see "email one body"

	Scenario: I can view the attachment
		When I am on the "emails/1" page
		And I click "SQ001.pdf"
		Then I should be looking at a pdf file