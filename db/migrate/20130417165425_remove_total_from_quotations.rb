class RemoveTotalFromQuotations < ActiveRecord::Migration
  def up
    remove_column :quotations, :total
  end

  def down
    add_column :quotations, :total, :decimal, precision: 10, scale: 2
  end
end
