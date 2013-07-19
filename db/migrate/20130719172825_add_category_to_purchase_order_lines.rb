class AddCategoryToPurchaseOrderLines < ActiveRecord::Migration
  def change
    add_column :purchase_order_lines, :category, :string
    add_column :purchase_order_lines, :position, :integer
  end
end
