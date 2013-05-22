class PurchaseOrdersController < ApplicationController
	before_filter :find_purchase_order, except: [:new, :create, :index ]

	 def show
    flash[:notice] = params[:warning] if params[:warning]
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PurchaseOrderPdf.new(@purchase_order)
        send_data pdf.render, filename: "#{@purchase_order.code}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

	def setup
		@purchase_order = PurchaseOrder.new
		@purchase_order.code = PurchaseOrder.next_code
		@purchase_order.supplier = Company.find(params[:supplier_id]) if params[:supplier_id]
    @purchase_order.project = Project.find(params[:project_id]) if params[:project_id]
    @purchase_order.client = Company.find(params[:client_id]) if params[:client_id]
	end

	def new
		@purchase_order = PurchaseOrder.new(params[:purchase_order])
		# @purchase_order.code = params[:purchase_order][:code]
		# @purchase_order.supplier = Company.find(params[:purchase_order][:supplier_id])
  #   @purchase_order.client = Company.find(params[:purchase_order][:client_id])
  #   @purchase_order.customer = Company.find(params[:purchase_order][:customer_id])
    @delivery_addresses = @purchase_order.client.addresses << Company.owned.first.addresses
	end

	def create
		@purchase_order = PurchaseOrder.new(params[:purchase_order])

		respond_to do |format|
			if @purchase_order.save
				@purchase_order.events.create!(state: 'open', user_id: current_user.id)
				format.html {redirect_to @purchase_order, flash: {success: "Purchase Order successfully created"}}
			else
				format.html {render action: 'new' }
			end
		end
	end

	def edit
		
	end

	def update
		if @purchase_order.update_attributes(params[:purchase_order])
			redirect_to @purchase_order, flash: {success: "Purchase Order successfully updated"}
		else
			render action: 'edit'
		end
	end

  def list_emails
    @emails = @purchase_order.emails
    render template: 'emails/index' 
  end

  def list_events
    @events = @purchase_order.events
    render template: 'events/index' 
  end

	private
	def find_purchase_order
		@purchase_order = PurchaseOrder.find(params[:id]) if params[:id]
	end
end