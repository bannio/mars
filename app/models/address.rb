class Address < ActiveRecord::Base
  # attr_accessible :body, :company_id, :name, :post_code
  
  belongs_to :company, inverse_of: :addresses
  has_many  :contacts
  has_many  :quotations
  has_many  :quotation_deliveries, class_name: 'Quotation', foreign_key: :delivery_address_id
  
  validates_presence_of :company_id, :name
  before_destroy :check_associations
  
  private
  
  def check_associations
    if !contacts.empty? ||
      !quotations.empty? ||
      !quotation_deliveries
      return false
    else
      return true
    end
  end
  
end
