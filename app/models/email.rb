class Email < ActiveRecord::Base
  # attr_accessible :attachment, :body, :emailable_id, :emailable_type, :from, :subject, :to
  belongs_to :emailable, polymorphic: true
<<<<<<< HEAD
  
  before_save :send_email
  
  private
  
  def send_email
    
    MarsMailer.quotation_email(from:    self.from,
                              to:       self.to,
                              subject:  self.subject,
                              body:     self.body,
                              id:     self.emailable_id).deliver
=======
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
>>>>>>> email
  end
end
