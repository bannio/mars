class MarsMailer < ActionMailer::Base
  default from: "sales@elderberry-furniture.com"

<<<<<<< HEAD
  def quotation_email(options)
    to = options[:to]
    from = options[:from]
    subject = options[:subject]
    body = options[:body]
    quote = Quotation.find(options[:id])
    @code = quote.code
    pdf = SalesQuotePdf.new(quote).render_file(File.join(output_path, filename))
    
    attachments[filename] = File.read(pdf)
    mail from: from, to: to, subject: subject, content: body
  end
  
  def output_path
    @output_path = File.join(Rails.root, 'data', 'quotations')
  end
  
  def filename
    @filename = "#{@code}.pdf"
=======
  # def quotation(options)
  #   from =        options[:from]
  #   to =          options[:to]
  #   subject =     options[:subject]
  #   @body =       options[:body]    # used in template
  #   attachment = options[:attachment]

  #   file = File.basename(attachment)
    
  #   attachments[file] = File.read(attachment)
  #   mail from: from, to: to, subject: subject
  # end

  def standard_email(obj)
    @body = obj.body
    file = File.basename(obj.attachment)
    attachments[file] = File.read(obj.attachment)
    mail from: obj.from, to: obj.to, subject: obj.subject

>>>>>>> email
  end
end
