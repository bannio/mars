class CreateQuotationLines < ActiveRecord::Migration
  def change
    create_table :quotation_lines do |t|
      t.integer :quotation_id
      t.string :name
      t.text :description
      t.integer :quantity
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
