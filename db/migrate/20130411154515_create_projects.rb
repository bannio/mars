class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :code
      t.string :name
      t.integer :company_id
      t.date :start_date
      t.date :end_date
      t.date :completion_date
      t.string :status
      t.integer :value
      t.text :notes

      t.timestamps
    end
  end
end
