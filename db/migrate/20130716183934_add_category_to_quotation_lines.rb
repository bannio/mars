class AddCategoryToQuotationLines < ActiveRecord::Migration
  def change
    add_column :quotation_lines, :category, :string
  end
end
