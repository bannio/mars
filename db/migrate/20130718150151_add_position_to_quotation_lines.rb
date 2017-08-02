class AddPositionToQuotationLines < ActiveRecord::Migration[4.2]
  def change
    add_column :quotation_lines, :position, :integer
  end
end
