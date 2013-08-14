class ChangeDiscountInPurchaseOrderLine < ActiveRecord::Migration
  # remove default so that placeholder works. Set value to zero in model
  def up
    remove_column :purchase_order_lines, :discount
    add_column :purchase_order_lines, :discount, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :purchase_order_lines, :discount, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
