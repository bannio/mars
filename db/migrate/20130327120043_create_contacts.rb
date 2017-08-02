class CreateContacts < ActiveRecord::Migration[4.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.references :company
      t.string :job_title
      t.references :address
      t.string :telephone
      t.string :mobile
      t.string :fax
      t.string :email
      t.text :notes

      t.timestamps
    end
    add_index :contacts, :company_id
    add_index :contacts, :address_id
  end
end
