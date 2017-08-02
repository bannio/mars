class AddColumnCcToEmail < ActiveRecord::Migration[4.2]
  def change
    add_column :emails, :cc, :text
  end
end
