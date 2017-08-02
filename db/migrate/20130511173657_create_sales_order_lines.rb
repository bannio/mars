class CreateSalesOrderLines < ActiveRecord::Migration[4.2]
  def change
    create_table :sales_order_lines do |t|
      t.integer :sales_order_id
      t.string :name
      t.text :description
      t.integer :quantity
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
