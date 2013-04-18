class ProjectsController < ApplicationController
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message
  
  def index
    @projects = Project.includes(:company).search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end
  
  def show
    @project = current_resource
  end
  
  def new
    @project = Project.new
    @project.code = Project.last ? Project.last.code.next : 'P0001'
    @project.start_date = Date.today
    @project.company_id = params[:company] || ''
    session[:return_to] = request.referer
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    @project = current_resource
    session[:return_to] = request.referer
  end
  
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to session[:return_to], flash: {success: 'Project was successfully created.'} }
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def update
    @project = current_resource

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to session[:return_to], flash: {success: 'Project was successfully updated.'} }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @project = current_resource 
    
    respond_to do |format|
      if @project.destroy
        format.html { redirect_to projects_url, flash: {success: 'Project was successfully deleted.'} }
      else
        format.html { redirect_to projects_url, flash: {error: 'Project not deleted. Maybe sales or purchase orders exist'} }
      end
    end
  end
  
  private
  
  def current_resource
    @current_resource ||= Project.find(params[:id]) if params[:id]
  end
  
  def not_found_message
    session[:return_to] ||= root_url
    redirect_to session[:return_to], flash: {error: 'Not authorised or no record found'}
  end
end
