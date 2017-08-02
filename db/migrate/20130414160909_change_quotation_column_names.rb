class ChangeQuotationColumnNames < ActiveRecord::Migration[4.2]
  def change
    rename_column :quotations, :company_id, :customer_id
  end
end
