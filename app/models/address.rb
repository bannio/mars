class Address < ActiveRecord::Base
  # attr_accessible :body, :company_id, :name, :post_code
  
  belongs_to :company, inverse_of: :addresses
  has_many :contacts
  
  validates_presence_of :company_id, :name
  before_destroy :check_use_by_contacts
  
  private
  
  def check_use_by_contacts
    if !self.contacts.empty?
      errors.add(:address, "This address is in use by contacts")
      false
    end
  end
  
end
