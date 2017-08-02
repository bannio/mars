class CreatePurchaseOrders < ActiveRecord::Migration[4.2]
  def change
    create_table :purchase_orders do |t|
      t.string :name
      t.belongs_to :project
      t.belongs_to :customer
      t.belongs_to :supplier
      t.belongs_to :contact
      t.date :issue_date
      t.text :notes
      t.belongs_to :address
      t.string :code
      t.text :description
      t.integer :delivery_address_id
      t.string :status
      t.decimal :total, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
    add_index :purchase_orders, :project_id
    add_index :purchase_orders, :customer_id
    add_index :purchase_orders, :supplier_id
    add_index :purchase_orders, :contact_id
    add_index :purchase_orders, :address_id
  end
end
