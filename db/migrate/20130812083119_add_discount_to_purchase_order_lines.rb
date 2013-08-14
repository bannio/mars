class AddDiscountToPurchaseOrderLines < ActiveRecord::Migration
  def change
    add_column :purchase_order_lines, :discount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
