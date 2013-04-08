class Company < ActiveRecord::Base
  has_many :addresses
  has_many :contacts #, inverse_of: :company
  # accepts_nested_attributes_for :contact
  
  validates_presence_of :name
  before_destroy :check_for_contacts, :check_for_addresses
  
private

  def check_for_contacts
    if !self.contacts.empty?
      false
    end
  end
  
  def check_for_addresses
    if !self.addresses.empty?
      false
    end
  end
  
  def self.search(search)
    if search.present?
      order(:name).where('name ilike :q', q: "%#{search}%")
    else
      order(:name).scoped
    end
  end
end
