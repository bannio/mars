require 'spec_helper'

describe Quotation do
  before(:each) do
    @attr = { 
        name:        "My quotation",
        project_id:  create(:project).id, 
        customer_id: create(:company).id,
        supplier_id: create(:company).id,
        address_id:  create(:address).id,
        contact_id:  create(:contact).id,
        issue_date:  Date.today,
        status:      "active",
        notes:       "some notes",
        code:        "SQ01",
        description:  "sq description",
        delivery_address_id: create(:address).id
    }
  end
  
  it "should require a name" do
    quote = Quotation.new(@attr.merge(name: ''))
    quote.should_not be_valid
  end
  
  it "should require a customer" do
    quote = Quotation.new(@attr.merge(customer_id: ''))
    quote.should_not be_valid
  end
  
  it "should require a supplier" do
    quote = Quotation.new(@attr.merge(supplier_id: ''))
    quote.should_not be_valid
  end
  
  it "should require a project" do
    quote = Quotation.new(@attr.merge(project_id: ''))
    quote.should_not be_valid
  end
  
  it "should delete all associated lines" do
    quote = Quotation.create(@attr)
    lines = quote.quotation_lines.create!(name: 'test item', 
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    expect {quote.destroy}.to change(QuotationLine, :count).by(-1)
  end
end
