require 'spec_helper'

describe PurchaseOrder do
  it "requires a customer_id" do
  	po = PurchaseOrder.new(customer_id: "")
  	expect(po.valid?).to be_false
  	expect(po.errors[:customer_id].any?).to be_true
  end
  it "requires a supplier_id" do
  	po = PurchaseOrder.new(supplier_id: "")
  	expect(po.valid?).to be_false
  	expect(po.errors[:supplier_id].any?).to be_true
  end
  it "requires a project_id" do
  	po = PurchaseOrder.new(project_id: "")
  	expect(po.valid?).to be_false
  	expect(po.errors[:project_id].any?).to be_true
  end
  it "requires a name" do
  	po = PurchaseOrder.new(name: "")
  	expect(po.valid?).to be_false
  	expect(po.errors[:name].any?).to be_true
  end
  it "requires a contact_id" do
  	po = PurchaseOrder.new(contact_id: "")
  	expect(po.valid?).to be_false
  	expect(po.errors[:contact_id].any?).to be_true
  end
  it "requires a client_id" do
  	po = PurchaseOrder.new(client_id: "")
  	expect(po.valid?).to be_false
  	expect(po.errors[:client_id].any?).to be_true
  end
  it "requires a due_date" do
  	po = PurchaseOrder.new(due_date: "")
  	expect(po.valid?).to be_false
  	expect(po.errors[:due_date].any?).to be_true
  end

  it "knows how to update its total" do
  	po = create(:purchase_order, total: "")
  	expect(po.update_total).to eq(0)
  	po.purchase_order_lines.create(name: "1", 
  																description: "test", 
  																quantity: 1, 
  																unit_price: 12.0)
  	expect(po.update_total).to eq(12.0)
  end

  it "creates the correct revison number" do
  	po = create(:purchase_order, code: "P001")
  	expect(po.update_code).to be_true
  	expect(po.code).to eq("P001R1")
  	expect(po.update_code).to be_true
  	expect(po.code).to eq("P001R2")
  end

  it "selects the correct delivery address name" do
  	po = create(:purchase_order, delivery_address_id: "")
  	expect(po.delivery_name).to eq("No delivery address")
  	addr = create(:address, name: "client address",
  								company_id: po.client_id)
  	po.delivery_address_id = addr.id
  	expect(po.delivery_name).to eq("MyClient")
  end
end
