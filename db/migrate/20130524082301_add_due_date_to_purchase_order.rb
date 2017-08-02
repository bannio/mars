class AddDueDateToPurchaseOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :purchase_orders, :due_date, :date
  end
end
