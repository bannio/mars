class AddReferenceToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :reference, :string
  end
end
