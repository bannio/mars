class RemoveStatusFromQuotations < ActiveRecord::Migration
  def up
    remove_column :quotations, :status
  end

  def down
    add_column :quotations, :status, :string
  end
end
