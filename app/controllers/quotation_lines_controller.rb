class QuotationLinesController < ApplicationController
  
  before_filter :find_quotation
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  
  def index
    @quotation_lines = QuotationLine.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @quotation_line = current_resource

    respond_to do |format|
      format.html
    end
  end

  def new
    @quotation_line = @quotation.quotation_lines.build
    session[:return_to] = request.referer
    
    respond_to do |format|
      format.html
    end
  end

  def edit
    @quotation_line = current_resource
    session[:return_to] = request.referer
  end

  def create
    @quotation_line = QuotationLine.new(params[:quotation_line])

    respond_to do |format|
      if @quotation_line.save
        format.html { redirect_to session[:return_to], flash: {success: 'Quotation line was successfully created.'} }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @quotation_line = current_resource
    params[:quotation_line][:total] = @quotation_line.quantity * @quotation_line.unit_price

    respond_to do |format|
      if @quotation_line.update_attributes(params[:quotation_line])
        format.html { redirect_to session[:return_to], flash: {success: 'Quotation line was successfully updated.'} }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @quotation_line = current_resource
    session[:return_to] = request.referer
    
    @quotation_line.destroy

    respond_to do |format|
      format.html { redirect_to session[:return_to] }
    end
  end

  private

  def current_resource
    @current_resource ||= QuotationLine.find(params[:id]) if params[:id]
  end
  
  def find_quotation
    if params[:quotation_id]
      @quotation = Quotation.find(params[:quotation_id])
    else
      @quotation = Quotation.find(params[:id]) unless params[:id] == nil
    end
  end
  
  def not_found_message
    session[:return_to]||= root_url
    redirect_to session[:return_to], flash: {error: 'Not authorised or no record found'}
  end
  
end
