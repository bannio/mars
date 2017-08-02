class AddCategoryToQuotationLines < ActiveRecord::Migration[4.2]
  def change
    add_column :quotation_lines, :category, :string
  end
end
