class ContactsController < ApplicationController
  
  before_filter :find_company
  before_filter :find_contact, except: [:new, :create, :index]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  
  def index
    @contacts = Contact.includes(:company).order(:name).search(params[:search]).page(params[:page])
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @contact = @company.contacts.build
    session[:return_to] = request.referer
  end
  
  def edit
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
    if request.referer.include?("contacts/#{@contact.id}")
      session[:return_to] = company_contacts_path
    else
      session[:return_to] = request.referer
    end

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

    def find_contact
      @contact = Contact.find(params[:id]) if params[:id]
    end
    
    def find_company
      @company = Company.find(params[:company_id]) if params[:company_id]
    end
    
    def not_found_message
      session[:return_to]||= root_url
      redirect_to session[:return_to], flash: {error: 'Not authorised or no record found'}
    end
end
