class QuotationLinesController < ApplicationController

  before_filter :find_quotation_line
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message

  def edit
    session[:return_to] = request.referer
  end

  def update
    respond_to do |format|
      if @quotation_line.update_attributes(params[:quotation_line])
        format.html { redirect_to session[:return_to], flash: {success: 'Quotation line was successfully updated.'} }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @quotation_line.destroy

    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def sort
    params[:quotation_line].each_with_index do |id, index|
      QuotationLine.where(:id => id).update_all(position: index+1)
    end
    render nothing: true
  end

  private
  def find_quotation_line
    @quotation_line = QuotationLine.find(params[:id]) unless params[:id] == nil
  end

  def not_found_message
    session[:return_to]||= root_url
    redirect_to session[:return_to], flash: {error: 'Not authorised or no record found'}
  end
end
