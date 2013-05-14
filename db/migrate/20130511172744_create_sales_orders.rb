class CreateSalesOrders < ActiveRecord::Migration
  def change
    create_table :sales_orders do |t|
      t.string :name
      t.integer :project_id
      t.integer :customer_id
      t.integer :supplier_id
      t.integer :contact_id
      t.date :issue_date
      t.text :notes
      t.integer :address_id
      t.string :code
      t.text :description
      t.integer :delivery_address_id

      t.timestamps
    end
  end
end
