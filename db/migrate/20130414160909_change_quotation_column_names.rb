class ChangeQuotationColumnNames < ActiveRecord::Migration
  def change
    rename_column :quotations, :company_id, :customer_id
  end
end
