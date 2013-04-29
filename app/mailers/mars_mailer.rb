class MarsMailer < ActionMailer::Base
  default from: "sales@elderberry-furniture.com"

  def quotation_email(user, contact, code)
    @user = user
    @contact = contact
    @code = code
    filepath = Rails.root.to_s + "/data/quotations/#{@code}.pdf"
    
    attachments["#{@code}.pdf"] = File.read(filepath)

    mail from: @user.email, to: @contact.email, subject: "Sales Quotation #{@code}"
  end
end
