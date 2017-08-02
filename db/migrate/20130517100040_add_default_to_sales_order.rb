class AddDefaultToSalesOrder < ActiveRecord::Migration[4.2]
  def change
  	change_column :sales_orders, :total, :decimal, :precision => 10, :scale => 2, :default => 0.00
  end
end
