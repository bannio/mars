class Company < ActiveRecord::Base
  has_many :addresses
  has_many :contacts #, inverse_of: :company
  
  validates_presence_of :name
end
