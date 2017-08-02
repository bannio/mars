class AddCodeToQuotations < ActiveRecord::Migration[4.2]
  def change
    add_column :quotations, :code, :string
  end
end
