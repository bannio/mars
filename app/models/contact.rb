class Contact < ApplicationRecord

   # attr_accessible :email, :fax, :job_title, :mobile, :name, :notes, :telephone

  belongs_to :company #, inverse_of: :contacts
  belongs_to :address #, inverse_of: :contacts
  has_many  :quotations


  validates_presence_of :name, :company_id
  validates :email, allow_blank: true,
                    uniqueness: { case_sensitive: false },
                    email_format: {message: 'format looks invalid'}

  scope :with_email,->{ where('email like :e', e: "%@%" )}

  before_destroy :check_associations

  def formatted_email
    name + ' <' + email + '>' unless email.empty?
  end

private

  def self.search(search)
    if search.present?
      where('name ilike :q', q: "%#{search}%")
    else
      all
    end
  end

  def check_associations
    if !quotations.empty?
      throw(:abort)
    else
      return true
    end
  end

end
