class Contact < ActiveRecord::Base
  
   # attr_accessible :email, :fax, :job_title, :mobile, :name, :notes, :telephone
   
  belongs_to :company #, inverse_of: :contacts
  belongs_to :address #, inverse_of: :contacts
  has_many  :quotations
 
  
  validates_presence_of :name, :company_id
  validates :email, allow_blank: true, 
                    uniqueness: { case_sensitive: false }, 
                    email_format: {message: 'format looks invalid'}
                    
  scope :with_email, where('email like :e', e: "%@%" )
                    
private

  def self.search(search)
    if search.present?
      order(:name).where('name ilike :q', q: "%#{search}%")
    else
      order(:name).scoped
    end
  end

end
