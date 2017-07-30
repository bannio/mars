class SalesOrderLinesController < ApplicationController
	before_action :find_model
	rescue_from ActiveRecord::RecordNotFound, with: :not_found_message

	def edit
		session[:return_to] = request.referer
	end

	def update

		respond_to do |format|
			if @sales_order_line.update_attributes(params[:sales_order_line])
				format.html {redirect_to session[:return_to], flash: {success: 'Order line was successfully updated.'}}
			else
				format.html {render action: 'edit'}
			end
		end
	end

	def destroy
		@sales_order_line.destroy

		respond_to do |format|
			format.html { redirect_back(fallback_location: root_url) }
		end
	end

	def sort
    params[:sales_order_line].each_with_index do |id, index|
      SalesOrderLine.update_all({position: index+1}, {id: id})
    end
    render nothing: true
	end

	private
	def find_model
		@sales_order_line = SalesOrderLine.find(params[:id]) if params[:id]
	end

	def not_found_message
    session[:return_to]||= root_url
    redirect_to session[:return_to], flash: {error: 'Not authorised or no record found'}
	end
end