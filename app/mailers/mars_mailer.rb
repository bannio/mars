class MarsMailer < ActionMailer::Base
  default from: "sales@elderberry-furniture.com"


  def standard_email(obj)
    @body = obj.body
    file = File.basename(obj.attachment)
    attachments[file] = File.read(obj.attachment)
    mail from: obj.from, to: obj.to, cc: obj.cc, subject: obj.subject
  end
end
