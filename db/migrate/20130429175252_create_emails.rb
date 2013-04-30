class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :to
      t.string :from
      t.string :subject
      t.text :body
      t.string :attachment
      t.belongs_to :emailable, polymorphic: true

      t.timestamps
    end
  end
end
