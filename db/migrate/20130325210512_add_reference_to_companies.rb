class AddReferenceToCompanies < ActiveRecord::Migration[4.2]
  def change
    add_column :companies, :reference, :string
  end
end
