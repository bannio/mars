When(/^I select PO contact "(.*?)"$/) do |contact|
  select( contact, from: 'Contact' )
end

When(/^I select PO client "(.*?)"$/) do |client|
  select( client, from: 'Client')
end

Given(/^I have setup a PO$/) do
	steps %{
		When I click "New Purchase Order"
		When I select customer "Elderberry"
		And I select PO client "Client"
		And I select supplier "Z Company"
		And I click button "Next"
	}
end