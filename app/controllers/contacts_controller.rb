class ContactsController < ApplicationController
  
  before_filter :find_company
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  
  def index
    @contacts = Contact.all
  end

  def show
    @contact = current_resource
  end

  def new
    @contact = @company.contacts.build
    session[:return_to] = request.referer
  end
  
  def edit
    @contact = current_resource
    session[:return_to] = request.referer
  end

  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to session[:return_to], flash: {success: 'Contact was successfully created.'} }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @contact = current_resource

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to session[:return_to], flash: {success: 'Contact was successfully updated.'} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact = current_resource
    session[:return_to] = request.referer

    respond_to do |format|
      if @contact.destroy
        format.html { redirect_to session[:return_to] }
        format.json { head :no_content }
      else
        format.html { redirect_to session[:return_to], flash: {error: 'Not able to delete contact'} }
      end
    end
  end
  
  private
    def current_resource
      @current_resource ||= Contact.find(params[:id]) if params[:id]
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
