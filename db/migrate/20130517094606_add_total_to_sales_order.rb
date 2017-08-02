class AddTotalToSalesOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :sales_orders, :total, :decimal, precision: 10, scale: 2
  end
end
