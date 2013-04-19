class Quotation < ActiveRecord::Base
  # attr_accessible :address_id, :company_id, :contact_id, :issue_date, :name, :notes, :project_id, :status, :supplier_id, :total
  
  belongs_to :customer, class_name: 'Company'
  belongs_to :supplier, class_name: 'Company'
  belongs_to :project
  belongs_to :address
  belongs_to :contact
  belongs_to :delivery_address, class_name: 'Address'
  
  has_many  :quotation_lines, dependent: :destroy
  accepts_nested_attributes_for :quotation_lines
  
  validates :customer_id, :supplier_id, :project_id, :name, presence: true
  
  def total
    total = quotation_lines.sum(:total)
  end
  
  def import(file)
    CSV.foreach(file.path, headers: true) do |row|
      if !self.quotation_lines.create(row.to_hash)
        flash[:alert] = 'some records failed validation'
        return
      end
    end
  end
  
end
