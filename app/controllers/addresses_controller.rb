class AddressesController < ApplicationController
  
  before_filter :find_company
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  
  def index
    @addresses = Address.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @addresses }
    end
  end

  def show
    @address = current_resource

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @address }
    end
  end

  def new
    @address = @company.addresses.build
    session[:return_to] = request.referer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @address }
    end
  end

  def edit
    @address = current_resource
    session[:return_to] = request.referer
  end

  def create
    @address = Address.new(params[:address])

    respond_to do |format|
      if @address.save
        format.html { redirect_to session[:return_to], flash: {success: 'Address was successfully created.'} }
        format.json { render json: @address, status: :created, location: @address }
      else
        format.html { render action: "new" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @address = current_resource

    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to session[:return_to], flash: {success: 'Address was successfully updated.'} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @address = Address.find(params[:id])
    session[:return_to] = request.referer

    respond_to do |format|
      if @address.destroy
        format.html { redirect_to session[:return_to] }
        format.json { head :no_content }
      else
        format.html { redirect_to session[:return_to], flash: {error: 'Not able to delete address, maybe in use by a contact'} }
      end
    end
  end

  private
    
    def current_resource
      @current_resource ||= Address.find(params[:id]) if params[:id]
    end
    
    def find_company
      if params[:company_id]
        @company = Company.find(params[:company_id])
      else
        @company = Company.find(params[:id]) unless params[:id] == nil
      end
    end
    
    def not_found_message
      session[:return_to]||= root_url
      redirect_to session[:return_to], flash: {error: 'Not authorised or no record found'}
    end
end
