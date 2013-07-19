class AddCategoryToSalesOrderLines < ActiveRecord::Migration
  def change
    add_column :sales_order_lines, :category, :string
    add_column :sales_order_lines, :position, :integer
  end
end
