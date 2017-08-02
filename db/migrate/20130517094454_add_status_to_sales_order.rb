class AddStatusToSalesOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :sales_orders, :status, :string
  end
end
