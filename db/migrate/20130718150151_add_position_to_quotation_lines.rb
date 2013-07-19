class AddPositionToQuotationLines < ActiveRecord::Migration
  def change
    add_column :quotation_lines, :position, :integer
  end
end
