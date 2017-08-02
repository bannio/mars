class AddColumnsToQuotations < ActiveRecord::Migration[4.2]
  def change
    add_column :quotations, :description, :text
    add_column :quotations, :delivery_address_id, :integer
  end
end
