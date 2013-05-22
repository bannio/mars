class CreatePurchaseOrderLines < ActiveRecord::Migration
  def change
    create_table :purchase_order_lines do |t|
      t.belongs_to :purchase_order
      t.string :name
      t.text :description
      t.integer :quantity
      t.decimal :unit_price, precision: 10, scale: 2, default: 0.0
      t.decimal :total, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
    add_index :purchase_order_lines, :purchase_order_id
  end
end
