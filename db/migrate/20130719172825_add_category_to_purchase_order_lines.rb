class AddCategoryToPurchaseOrderLines < ActiveRecord::Migration[4.2]
  def change
    add_column :purchase_order_lines, :category, :string
    add_column :purchase_order_lines, :position, :integer
  end
end
