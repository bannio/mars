@posearch
Feature: In order to build up new purchase orders more easily 
        I want to be able to search for previously used items
        by a word or combination of words.

Background:
  Given I have the following purchase order line items
  |item      | specification         | 
  |Chair     | black, office chair, green legs | 
  |Chair     | black, office chair, black legs | 
  |Chair     | green, office chairs | 
  |Chair     | red, office chair 1 | 
  |Red Chair | office chair 2 | 
  |Office    | red chair companies | 
  And I am logged in as a user with a role "purchase" 

Scenario: There is a search button when the purchase order is open
  When I visit an open purchase order page
  Then I should see a "Search" button

Scenario: There is no search button when the purchase order is not open
  When I visit a not open purchase order page
  Then I should not see a "Search" button

Scenario: It accepts single word searches
  When I visit an open purchase order page
  And I click "Search"
  When I enter "chair"
  Then I see "6" results

Scenario: It accepts multi-word searches in any order
  When I visit an open purchase order page
  And I click "Search"
  When I enter "chair black"
  Then I see "2" results 

Scenario: It searches in the item name field
  When I visit an open purchase order page
  And I click "Search"
  When I enter "office"
  Then I see "6" results 

Scenario: It is case insensitive
  When I visit an open purchase order page
  And I click "Search"
  When I enter "Red"
  Then I see "3" results 

Scenario: It ranks results by number of word occurrances
  When I visit an open purchase order page
  And I click "Search"
  When I enter "black"
  Then I see "black legs" before "green legs" 

Scenario: It ranks words in item ahead of specification
  When I visit an open purchase order page
  And I click "Search"
  When I enter "red"
  Then I see "chair 2" before "chair 1" 

Scenario: It stems words for plurals
  When I visit an open purchase order page
  And I click "Search"
  When I enter "chairs"
  Then I see "6" results 

Scenario: It stems words for plurals
  When I visit an open purchase order page
  And I click "Search"
  When I enter "company"
  Then I see "1" results 