class CreateSalesLinks < ActiveRecord::Migration
  def change
    create_table :sales_links do |t|
      t.belongs_to :purchase_order_line
      t.belongs_to :sales_order_line

      t.timestamps
    end
    add_index :sales_links, :purchase_order_line_id
    add_index :sales_links, :sales_order_line_id
  end
end
