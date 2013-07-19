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
        notes:       "some notes",
        code:        "SQ01",
        description:  "sq description",
        delivery_address_id: create(:address).id,
        status:       "open"
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
  
  it "should require a contact" do
    quote = Quotation.new(@attr.merge(contact_id: ''))
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
  
  it "does not issue quotes with no lines" do
    quote = Quotation.create(@attr)
    user = FactoryGirl.create(:user)
    quote.issue(user).should be_false
  end
  
  it "does issue quotes with lines" do
    quote = Quotation.create(@attr)
    lines = quote.quotation_lines.create!(name: 'test item', 
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    quote.issue(user).should be_valid
  end
  
  it "does not issue quotes unless current_state is open" do
    quote = Quotation.create(@attr.merge(status: 'issued'))
    lines = quote.quotation_lines.create!(name: 'test item', 
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    quote.events.create(user_id: user.id, state: 'issued')
    quote.issue(user).should be_false
  end

  it "does not cancel ordered quotes" do
    quote = Quotation.create(@attr.merge(status: 'ordered'))
    lines = quote.quotation_lines.create!(name: 'test item', 
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    quote.events.create(user_id: user.id, state: 'ordered')
    quote.cancel(user).should be_false
  end
  it "can cancel open quotes" do
    quote = Quotation.create(@attr)
    lines = quote.quotation_lines.create!(name: 'test item', 
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    quote.events.create(user_id: user.id, state: 'open')
    quote.cancel(user).should be_valid
  end
    it "can cancel issued quotes" do
    quote = Quotation.create(@attr)
    lines = quote.quotation_lines.create!(name: 'test item', 
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    quote.events.create(user_id: user.id, state: 'issued')
    quote.cancel(user).should be_valid
  end
  it "creates a pdf version of itself" do
    quote = Quotation.create(@attr)
    supplier_address = create(:address, company_id: quote.supplier_id, body: "body", post_code: "ABC")
    lines = quote.quotation_lines.create!(name: 'test item', 
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    expect(File.basename(quote.create_pdf)).to eq 'SQ01.pdf'
  end
end
