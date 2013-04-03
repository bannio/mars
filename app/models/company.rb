class Company < ActiveRecord::Base
  has_many :addresses
  has_many :contacts #, inverse_of: :company
  # accepts_nested_attributes_for :contact
  
  validates_presence_of :name
end
