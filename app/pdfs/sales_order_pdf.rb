class SalesOrderPdf < Prawn::Document
	def initialize(sales_order)
    super(bottom_margin: 50)
    @sales_order = sales_order
		text_box 'sales order'
	end
end