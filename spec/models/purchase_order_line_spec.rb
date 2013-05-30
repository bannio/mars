require 'spec_helper'

describe PurchaseOrderLine do

	before do
		@po = create(:purchase_order, total: 0)
	end
  it "updates the PO total after save and destroy" do
  	pol = @po.purchase_order_lines.create(name: "desk", description: "office", quantity: 1, unit_price: 10)
  	expect(@po.purchase_order_lines.count).to eq(1)
  	expect(@po.reload.total).to eq(10)
  	PurchaseOrderLine.destroy(pol)
  	expect(@po.reload.total).to eq(0)
  end

  it "requires a name" do
  	expect(PurchaseOrderLine.new(name: nil)).to have(1).errors_on(:name)
  end
end
