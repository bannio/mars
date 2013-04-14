class Project < ActiveRecord::Base
  
  belongs_to :company
  
  validates_presence_of :company_id, :code, :name
  
  private
  
  def self.search(search)
    if search.present?
      order(:code).where('name ilike :q', q: "%#{search}%")
    else
      order(:code).scoped
    end
  end
  
end
