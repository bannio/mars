class RemoveStatusFromQuotations < ActiveRecord::Migration[4.2]
  def up
    remove_column :quotations, :status
  end

  def down
    add_column :quotations, :status, :string
  end
end
