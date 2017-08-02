class AddDiscountToPurchaseOrderLines < ActiveRecord::Migration[4.2]
  def change
    add_column :purchase_order_lines, :discount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
