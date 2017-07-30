require 'spec_helper'

describe Email do

	let(:quote) { create(:quotation)}

	before(:each) do
		@attr = {
					emailable_type: 'Quotation',
					emailable_id: quote.id,
					to: 'fred@example.com',
					from: 'bloggs@example.com',
					subject: 'My test email',
					body: 'Hello',
					attachment: 'spec/fixtures/SQ001.pdf',
					cc: ["","joe@example.com","j.d@example.com"]
					}
	end


	it "is valid with all attributes present" do
		email = Email.new(@attr)
		expect(email).to be_valid
	end

	it "is not valid with missing to" do
		email = Email.new(@attr.merge(to: ''))
		expect(email).to be_invalid
	end

	it "is not valid with missing from" do
		email = Email.new(@attr.merge(from: ''))
		expect(email).to be_invalid
	end

	it "is not valid with missing subject" do
		email = Email.new(@attr.merge(subject: ''))
		expect(email).to be_invalid
	end

	it "is valid with missing body" do
		email = Email.new(@attr.merge(body: ''))
		expect(email).to be_valid
	end

	it "is not valid with missing attachment" do
		email = Email.new(@attr.merge(attachment: ''))
		expect(email).to be_invalid
	end

	it "is not valid with missing emailable_type" do
		email = Email.new(@attr.merge(emailable_type: ''))
		expect(email).to be_invalid
	end

	it "is not valid with missing emailable_id" do
		email = Email.new(@attr.merge(emailable_id: ''))
		expect(email).to be_invalid
	end

	it "checks for a valid attachment" do
		email = Email.new(@attr.merge(attachment: 'dummy'))
		expect(email).to be_invalid
	end

  it "sends an email on save" do
  	email = Email.create(@attr.merge(to: 'save@example.com'))
  	expect(last_email.to).to include('save@example.com')
  end

  it "is valid with missing cc" do
		email = Email.new(@attr.merge(cc: ''))
		expect(email).to be_valid
	end

end
