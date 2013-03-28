class Address < ActiveRecord::Base
  # attr_accessible :body, :company_id, :name, :post_code
  
  belongs_to :company, inverse_of: :addresses
  has_many :contacts
  
  validates_presence_of :company_id, :name
  
end
