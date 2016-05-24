class PurchaseOrderLinesController < ApplicationController
	before_filter :find_model
	rescue_from ActiveRecord::RecordNotFound, with: :not_found_message

	def edit
		session[:return_to] = request.referer
	end

	def update

		respond_to do |format|
			if @purchase_order_line.update_attributes(params[:purchase_order_line])
				format.html {redirect_to session[:return_to], flash: {success: 'Order line was successfully updated.'}}
			else
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		@purchase_order_line.destroy

		respond_to do |format|
			format.html { redirect_to :back, flash: {success: 'Order line was successfully deleted.'} }
		end
	end

	def sort
		puts params[:purchase_order_line]
    params[:purchase_order_line].each_with_index do |id, index|
      # PurchaseOrderLine.update_all({position: index+1}, {id: id})
			PurchaseOrderLine.where(:id => id).update_all({position: index+1})
    end
    render nothing: true
	end

	private
	def find_model
		@purchase_order_line = PurchaseOrderLine.find(params[:id]) if params[:id]
	end

	def not_found_message
    session[:return_to]||= root_url
    redirect_to session[:return_to], flash: {error: 'Not authorised or no record found'}
	end
end
