module EmailHelper
	def format_attachment(email)
		file = "#{email.emailable.code}.pdf"
		folder = email.emailable_type.downcase
		attachment = File.join(Rails.root, 'data', folder, file)
	end
end