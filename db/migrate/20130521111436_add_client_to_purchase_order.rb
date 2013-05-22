class AddClientToPurchaseOrder < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :client_id, :integer
  end
end
