require 'spec_helper'

describe QuotationLine do
  let(:quote) { create(:quotation) }
  before(:each) do
    @attr = {
        name:        "item name",
        description:  "description of line",
        quantity:     2,
        unit_price:   2.0,
        total:        nil,
        quotation_id: quote.id
      }

  end

  it "is valid with these attributes" do
    line = QuotationLine.new(@attr)
    expect(line).to be_valid
  end

  it "requires a name" do
    line = QuotationLine.new(@attr.merge(name: ''))
    expect(line).to_not be_valid
  end

  it "calculates the total correctly" do
    line = QuotationLine.new(@attr)
    line.save
    expect(line.total).to eq(4.0)
  end

  it "replaces nil with zero in quantity" do
    line = QuotationLine.new(@attr.merge(quantity: ''))
    expect(line).to be_valid
    line.save
    expect(line.quantity).to eq(0)
  end

  it "replaces nil with zero in price" do
    line = QuotationLine.new(@attr.merge(unit_price: ''))
    expect(line).to be_valid
    line.save
    expect(line.unit_price).to eq(0)
  end

  it "calculates the total correctly even with no inputs" do
    line = QuotationLine.new(@attr.merge(unit_price: '', quantity: ''))
    line.save
    expect(line.total).to eq(0)
  end

end
