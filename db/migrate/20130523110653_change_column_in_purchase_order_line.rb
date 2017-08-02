class ChangeColumnInPurchaseOrderLine < ActiveRecord::Migration[4.2]
  def up
  	change_column :purchase_order_lines, :unit_price, :decimal, precision: 10, scale: 2
  end

  def down
  	change_column :purchase_order_lines, :unit_price, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
