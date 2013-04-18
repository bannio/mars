class AddCodeToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :code, :string
  end
end
