require 'spec_helper'

describe Event do
  it "is valid with a state of 'open'" do
  	event = Event.new(
  		eventable_id: 1,
  		eventable_type: 'Quotation',
  		state: 'open',
  		user_id: 1)
  	expect(event).to be_valid
  end
  it "is not valid with a state of 'fred' for quotation" do
  	event = Event.new(
  		eventable_id: 1,
  		eventable_type: 'Quotation',
  		state: 'fred',
  		user_id: 1)
  	expect(event).to be_invalid
  end

  it "knows what the latest state is" do
 	event = Event.create(
  		eventable_id: 1,
  		eventable_type: 'Quotation',
  		state: 'cancelled',
  		user_id: 1)
  	expect(Event.with_last_state('cancelled')).to eq [event]
  end

	it "knows what the latest state is" do
		event = Event.create(
			eventable_id: 1,
			eventable_type: 'Quotation',
			state: 'cancelled',
			user_id: 1)
		expect(Event.with_last_state('open')).to eq []
  end
end
