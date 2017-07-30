require 'spec_helper'

describe Event do
  before :each do
    @quotation = create(:quotation)
  end

  it "is valid with a state of 'open'" do
    event = create(:event, :in_open_state)
  	expect(event).to be_valid
  end
  it "is not valid with a state of 'fred' for quotation" do
    event = build(:event)
    event.state = 'fred'
  	expect(event).to be_invalid
  end

  it "knows what the latest state is" do
    event = create(:event, :in_cancelled_state)
  	expect(Event.with_last_state('cancelled')).to eq [event]
  end

	it "knows what the latest state is" do
    event = create(:event, :in_open_state)
		expect(Event.with_last_state('issued')).to eq []
  end

  it "validates state for purchase orders" do
    event = build(:purchase_order_event)
    expect(event).to be_valid
    event.state = 'invalid_state'
    expect(event).to be_invalid
  end

  it "validates state for sales orders" do
    event = build(:sales_order_event)
    expect(event).to be_valid
    event.state = 'invalid_state'
    expect(event).to be_invalid
  end
end
