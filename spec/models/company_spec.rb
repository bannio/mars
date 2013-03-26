require 'spec_helper'

describe Company do
  
  before(:each) do
    @attr = {
      name: "My company",
      reference: 'ABC123'
    }
  end
  
  it "should require a name" do
    company = Company.new(@attr.merge(name: ''))
    company.should_not be_valid
  end
  
end
