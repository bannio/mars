require 'spec_helper'

describe SalesOrderLine do
  before :each do
  	@attr = {
        name:        "item name",
        description:  "description of line",
        quantity:     2,
        unit_price:   2.0,
        total:        nil
    }
    @sales_order = create(:sales_order)
  end

  it "is valid with these attributes" do
    line = SalesOrderLine.new(@attr)
    expect(line).to be_valid
  end

  it "requires a name" do
    line = SalesOrderLine.new(@attr.merge(name: ''))
    expect(line).to_not be_valid
  end

  it "calculates the total correctly" do
    line = SalesOrderLine.new(@attr.merge(sales_order_id: @sales_order.id))
    line.save
    expect(line.total).to eq(4.0)
  end

  it "replaces nil with zero in quantity" do
    line = SalesOrderLine.new(@attr.merge(quantity: '', sales_order_id: @sales_order.id))
    expect(line).to be_valid
    line.save
    expect(line.quantity).to eq(0)
  end

  it "replaces nil with zero in price" do
    line = SalesOrderLine.new(@attr.merge(unit_price: '', sales_order_id: @sales_order.id))
    expect(line).to be_valid
    line.save
    expect(line.unit_price).to eq(0)
  end

  it "calculates the total correctly even with no inputs" do
    line = SalesOrderLine.new(@attr.merge(unit_price: '', quantity: '', sales_order_id: @sales_order.id))
    line.save
    expect(line.total).to eq(0)
  end
end
