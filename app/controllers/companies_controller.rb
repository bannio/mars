class CompaniesController < ApplicationController
  before_filter :find_company, except: [:new, :create, :index ]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  
  def index
    @companies = Company.order(:name).search(params[:search]).page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
      format.js
    end
  end

  def show
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
    if @company.destroy
      redirect_to companies_url, flash: {success: 'Company successfully removed'}
    else
      redirect_to @company, flash: {error: 'The company has dependents'}
    end
    
  end

  # def destroy    
  #     begin
  #       @company.destroy
  #       flash[:success] = 'Company was successfully deleted.'
  #     rescue ActiveRecord::DeleteRestrictionError => e
  #       @company.errors.add(:base, e)
  #       flash[:error] = "#{e}"
  #     ensure
  #       @company ? (redirect_to @company) : (redirect_to companies_url)
  #     end
  # end

  private
    
    def find_company
      @company ||= Company.find(params[:id]) if params[:id]
    end
    
    def not_found_message
      session[:return_to]||= root_url
      redirect_to session[:return_to], flash: {error: 'Not authorised or no record found'}
    end
end
