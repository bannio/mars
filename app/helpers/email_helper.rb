module EmailHelper
	def format_attachment(email)
		file = "#{email.emailable.code}.pdf"
		folder = email.emailable_type.downcase
		File.join(ENV["MARS_DATA"], folder, file)
	end

	def format_owner_link(email)
		if email.emailable_type == 'PurchaseOrder'
			link_to 'Supplier', company_path(@email.emailable.supplier_id)
		else
			link_to 'Customer', company_path(@email.emailable.customer_id)
		end
	end

	def cancel_path(email)
		case email.emailable_type
		when 'PurchaseOrder'
			purchase_order_path(@email.emailable)
		when 'SalesOrder'
			sales_order_path(@email.emailable)
		when 'Quotation'
			quotation_path(@email.emailable)
		else
			:back
		end
	end

	def cc_list(cc)
		# the cc is an array with an empty first member that comes from a multiple select 
		# e.g. ["","fred@bloggs.com","joe@bloggs.com"]
		# This method converts it to a string for display
		# e.g. "fred@bloggs.com, joe@blogs.com"
		if cc
			cc_list = cc * ','
			cc_list.gsub(/^,/,"").gsub(/,/,", ")
		end
	end
end