class Email < ActiveRecord::Base
  # attr_accessible :attachment, :body, :emailable_id, :emailable_type, :from, :subject, :to
  belongs_to :emailable, polymorphic: true
  validates :to, :from, :subject, :emailable_type, :emailable_id, :attachment, presence: true
  validate :attachment_exists?
  before_save :send_email
  
  private

  def send_email
    MarsMailer.standard_email(self).deliver
  end

  def attachment_exists?
    if File.exists?(attachment)
      true
    else
      errors.add(:attachment, "attachment file not found")
      false
    end
  end

  def self.search(search)
    if search.present?
      where('emails.attachment ilike :q', q: "%#{search}%")
    else
      scoped
    end
  end
end
