require 'spec_helper'

describe QuotationLine do
  before(:each) do
    @attr = { 
        name:        "item name",
        description:  "description of line",
        quantity:     2,
        unit_price:   2.0,  
        total:        nil
    }
  end
  
  it "is valid with these attributes" do
    line = QuotationLine.new(@attr)
    line.should be_valid
  end
  
  it "requires a name" do
    line = QuotationLine.new(@attr.merge(name: ''))
    line.should_not be_valid
  end
  
  it "calculates the total correctly" do
    line = QuotationLine.new(@attr)
    line.save
    line.total.should == 4.0
  end
  
  it "replaces nil with zero in quantity" do
    line = QuotationLine.new(@attr.merge(quantity: ''))
    line.should be_valid
    line.save
    line.quantity.should == 0
  end
  
  it "replaces nil with zero in price" do
    line = QuotationLine.new(@attr.merge(unit_price: ''))
    line.should be_valid
    line.save
    line.unit_price.should == 0
  end
  
  it "calculates the total correctly even with no inputs" do
    line = QuotationLine.new(@attr.merge(unit_price: '', quantity: ''))
    line.save
    line.total.should == 0
  end
  
end
