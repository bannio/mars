class Project < ActiveRecord::Base
  
  belongs_to :company
  has_many  :quotations
  
  validates_presence_of :company_id, :code, :name
  validate :valid_dates
  
  def valid_dates
    errors.add(:end_date, 'must be after start') unless !self.end_date || self.start_date && self.end_date && self.end_date > self.start_date
  end
  
  private
  
  def self.search(search)
    if search.present?
      order(:code).where('name ilike :q', q: "%#{search}%")
    else
      order(:code).scoped
    end
  end
  
end
