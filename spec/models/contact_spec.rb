require 'spec_helper'

describe Contact do

  before(:each) do
    @attr = {
      name: "My contact",
      job_title: "dogsbody",
      company_id: create(:company).id,
      address_id: create(:address).id,
      # post_code: 'AB1 2CD',
      telephone: '0123456789',
      mobile: '0765432189',
      fax: '012341234',
      email: 'contact@example.com',
      notes: 'some words'
    }
  end

  it "should require a name" do
    contact = Contact.new(@attr.merge(name: ''))
    expect(contact).to_not be_valid
  end

  it "does not require an email" do
    contact = Contact.new(@attr.merge(email: ''))
    expect(contact).to be_valid
  end

  it "should validate email if given" do
    contact = Contact.new(@attr.merge(email: 'bad-email'))
    expect(contact).to_not be_valid
  end

  it "should require a company_id" do
    contact = Contact.new(@attr.merge(company_id: ''))
    expect(contact).to_not be_valid
  end


end
