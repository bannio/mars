class Email < ActiveRecord::Base
  # attr_accessible :attachment, :body, :emailable_id, :emailable_type, :from, :subject, :to
  belongs_to :emailable, polymorphic: true
  
  before_save :send_email
  
  private
  
  def send_email
    
    MarsMailer.quotation_email(from:    self.from,
                              to:       self.to,
                              subject:  self.subject,
                              body:     self.body,
                              id:     self.emailable_id).deliver
  end
end
