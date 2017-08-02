class CreateAddresses < ActiveRecord::Migration[4.2]
  def change
    create_table :addresses do |t|
      t.integer :company_id
      t.string :name
      t.text :body
      t.string :post_code

      t.timestamps
    end
  end
end
