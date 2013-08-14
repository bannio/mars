require 'spec_helper'

describe PurchaseOrderLine do

	before do
		@po = create(:purchase_order, total: 0)
	end
  it "updates the PO total after save and destroy" do
  	pol = @po.purchase_order_lines.create(name: "desk", 
                                          description: "office", 
                                          quantity: 1, 
                                          unit_price: 10,
                                          discount: 50)
  	expect(@po.purchase_order_lines.count).to eq(1)
  	expect(@po.reload.total).to eq(5)
  	PurchaseOrderLine.destroy(pol)
  	expect(@po.reload.total).to eq(0)
  end

  it "calculates the PO total with positive discount" do
    pol = @po.purchase_order_lines.create(name: "desk", 
                                          description: "office", 
                                          quantity: 1, 
                                          unit_price: 10,
                                          discount: 25)
    expect(@po.purchase_order_lines.count).to eq(1)
    expect(@po.reload.total).to eq(7.5)
  end

  it "calculates the PO total with negative discount" do
    pol = @po.purchase_order_lines.create(name: "desk", 
                                          description: "office", 
                                          quantity: 1, 
                                          unit_price: 10,
                                          discount: -25)
    expect(@po.purchase_order_lines.count).to eq(1)
    expect(@po.reload.total).to eq(12.5)
  end

  it "calculates the PO total with zero discount" do
    pol = @po.purchase_order_lines.create(name: "desk", 
                                          description: "office", 
                                          quantity: 1, 
                                          unit_price: 10,
                                          discount: 0)
    expect(@po.purchase_order_lines.count).to eq(1)
    expect(@po.reload.total).to eq(10)
  end

  it "calculates the PO total with discount over 100%" do
    pol = @po.purchase_order_lines.create(name: "desk", 
                                          description: "office", 
                                          quantity: 1, 
                                          unit_price: 10,
                                          discount: 125)
    expect(@po.purchase_order_lines.count).to eq(1)
    expect(@po.reload.total).to eq(-2.5)
  end

  it "requires a name" do
  	expect(PurchaseOrderLine.new(name: nil)).to have(1).errors_on(:name)
  end
end
