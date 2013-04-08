class CompaniesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  
  def index
    @companies = Company.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
      format.js
    end
  end

  def show
    @company = current_resource

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  def edit
    @company = current_resource
  end

  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, flash: {success: 'Company was successfully created.'} }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @company = current_resource

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, flash: {success: 'Company was successfully updated.'} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company = current_resource 
    
    respond_to do |format|
      if @company.destroy
        format.html { redirect_to companies_url, flash: {success: 'Company was successfully deleted.'} }
      else
        format.html { redirect_to companies_url, flash: {error: 'Company not deleted. Maybe contacts or addresses exist'} }
      end
    end
  end

  private
    
    def current_resource
      @current_resource ||= Company.find(params[:id]) if params[:id]
    end
    
    def not_found_message
      session[:return_to]||= root_url
      redirect_to session[:return_to], flash: {error: 'Not authorised or no record found'}
    end
end
