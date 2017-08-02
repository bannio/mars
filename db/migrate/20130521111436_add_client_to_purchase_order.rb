class AddClientToPurchaseOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :purchase_orders, :client_id, :integer
  end
end
