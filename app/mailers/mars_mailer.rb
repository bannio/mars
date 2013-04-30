class MarsMailer < ActionMailer::Base
  default from: "sales@elderberry-furniture.com"

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
  end
end
