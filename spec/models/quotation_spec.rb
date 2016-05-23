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
    expect(quote).to_not be_valid
  end

  it "should require a customer" do
    quote = Quotation.new(@attr.merge(customer_id: ''))
    expect(quote).to_not be_valid
  end

  it "should require a supplier" do
    quote = Quotation.new(@attr.merge(supplier_id: ''))
    expect(quote).to_not be_valid
  end

  it "should require a project" do
    quote = Quotation.new(@attr.merge(project_id: ''))
    expect(quote).to_not be_valid
  end

  it "should require a contact" do
    quote = Quotation.new(@attr.merge(contact_id: ''))
    expect(quote).to_not be_valid
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
    expect(quote.issue(user)).to be false
  end

  it "does issue quotes with lines" do
    quote = Quotation.create(@attr)
    lines = quote.quotation_lines.create!(name: 'test item',
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    expect(quote.issue(user)).to be_valid
  end

  it "does not issue quotes unless current_state is open" do
    quote = Quotation.create(@attr.merge(status: 'issued'))
    lines = quote.quotation_lines.create!(name: 'test item',
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    quote.events.create(user_id: user.id, state: 'issued')
    expect(quote.issue(user)).to be false
  end

  it "does not cancel ordered quotes" do
    quote = Quotation.create(@attr.merge(status: 'ordered'))
    lines = quote.quotation_lines.create!(name: 'test item',
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    quote.events.create(user_id: user.id, state: 'ordered')
    expect(quote.cancel(user)).to be_falsey
  end
  it "can cancel open quotes" do
    quote = Quotation.create(@attr)
    lines = quote.quotation_lines.create!(name: 'test item',
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    quote.events.create(user_id: user.id, state: 'open')
    expect(quote.cancel(user)).to be_valid
  end
    it "can cancel issued quotes" do
    quote = Quotation.create(@attr)
    lines = quote.quotation_lines.create!(name: 'test item',
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    user = FactoryGirl.create(:user)
    quote.events.create(user_id: user.id, state: 'issued')
    expect(quote.cancel(user)).to be_valid
  end

  # this test failed on conversion to Rails 4 because the quote.create_pdf method does
  # not return a string
  #   expect(File.basename(quote.create_pdf)).to eq 'SQ01.pdf'
  # However, this is not testing what it says it is, so a re-write is required
  it "creates a pdf version of itself" do
    quote = Quotation.create(@attr)
    supplier_address = create(:address, company_id: quote.supplier_id, body: "body", post_code: "ABC")
    lines = quote.quotation_lines.create!(name: 'test item',
                                    description: 'test item description',
                                    quantity: 12,
                                    unit_price: 10.0)
    # expect(File.basename(quote.create_pdf)).to eq 'SQ01.pdf'
    quote.create_pdf
    #  expected file path
    output_path = File.join(ENV["MARS_DATA"], "quotation/SQ01.pdf")
    expect(File).to exist(output_path)
  end
end
