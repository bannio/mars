require 'spec_helper'

describe PurchaseOrder do
  let(:no_delivery_address_po) { create(:purchase_order, :no_delivery_address) }
  let(:delivery_address) { create(:delivery_address) }

  it "requires a customer_id" do
  	po = PurchaseOrder.new(customer_id: "")
  	expect(po.valid?).to be false
  	expect(po.errors[:customer_id].any?).to be true
  end
  it "requires a supplier_id" do
  	po = PurchaseOrder.new(supplier_id: "")
  	expect(po.valid?).to be false
  	expect(po.errors[:supplier_id].any?).to be true
  end
  it "requires a project_id" do
  	po = PurchaseOrder.new(project_id: "")
  	expect(po.valid?).to be false
  	expect(po.errors[:project_id].any?).to be true
  end
  it "requires a name" do
  	po = PurchaseOrder.new(name: "")
  	expect(po.valid?).to be false
  	expect(po.errors[:name].any?).to be true
  end
  it "requires a contact_id" do
  	po = PurchaseOrder.new(contact_id: "")
  	expect(po.valid?).to be false
  	expect(po.errors[:contact_id].any?).to be true
  end
  it "requires a client_id" do
  	po = PurchaseOrder.new(client_id: "")
  	expect(po.valid?).to be false
  	expect(po.errors[:client_id].any?).to be true
  end
  it "requires a due_date" do
  	po = PurchaseOrder.new(due_date: "")
  	expect(po.valid?).to be false
  	expect(po.errors[:due_date].any?).to be true
  end

  it "knows how to update its total" do
  	po = create(:purchase_order, total: 0)
  	expect(po.total).to eq(0)
  	po.purchase_order_lines.create(name: "1",
  																description: "test",
  																quantity: 1,
  																unit_price: 12.0)
    po.update_total
  	expect(po.total).to eq(12.0)
  end

  it "creates the correct revison number" do
  	po = create(:purchase_order, code: "P001")
  	expect(po.update_code).to be true
  	expect(po.code).to eq("P001R1")
  	expect(po.update_code).to be true
  	expect(po.code).to eq("P001R2")
  end

  it "selects the correct delivery address name" do
  	po = no_delivery_address_po
  	expect(po.delivery_name).to eq("No delivery address")
  	# addr = create(:address, name: "client address",
  	# 							company_id: po.client_id)
  	po.delivery_address_id = delivery_address.id
  	expect(po.delivery_name).to eq("MyClient")
  end
end
