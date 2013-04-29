class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :state
      t.integer :user_id
      t.belongs_to :eventable, polymorphic: true

      t.timestamps
    end
    add_index :events, [:eventable_id, :eventable_type]
  end
end
