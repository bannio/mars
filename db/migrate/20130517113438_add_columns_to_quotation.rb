class AddColumnsToQuotation < ActiveRecord::Migration[4.2]
  def change
    add_column :quotations, :status, :string
    add_column :quotations, :total, :decimal, precision: 10, scale: 2, default: 0.00
  end
end
