class AddCategoryToSalesOrderLines < ActiveRecord::Migration[4.2]
  def change
    add_column :sales_order_lines, :category, :string
    add_column :sales_order_lines, :position, :integer
  end
end
