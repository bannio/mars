class RemoveTotalFromQuotations < ActiveRecord::Migration[4.2]
  def up
    remove_column :quotations, :total
  end

  def down
    add_column :quotations, :total, :decimal, precision: 10, scale: 2
  end
end
