require 'spec_helper'

describe Address do

  before(:each) do
    @attr = {
      company_id: create(:company).id,
      name: "My company address",
      body: "Office 1st Street My Town",
      post_code: 'AB1 2CD'
    }
  end

  it "should require a company" do
    address = Address.new(@attr.merge(company_id: ''))
    expect(address).to_not be_valid
  end

  it "should require a name" do
    address = Address.new(@attr.merge(name: ''))
    expect(address).to_not be_valid
  end
end
