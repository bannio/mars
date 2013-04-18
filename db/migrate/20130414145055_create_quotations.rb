class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.string :name
      t.integer :project_id
      t.integer :company_id
      t.integer :supplier_id
      t.integer :contact_id
      t.date :issue_date
      t.decimal :total, precision: 10, scale: 2
      t.string :status
      t.text :notes
      t.integer :address_id

      t.timestamps
    end
  end
end
