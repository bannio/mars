class ProjectsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_message

  helper_method :sort_column, :sort_direction

  def index
    @projects = Project.includes(:company).
                order(sort_column + " " + sort_direction).
                search(params[:search]).
                page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @project = current_resource
  end

  def new
    @project = Project.new
    @project.code = Project.last ? Project.last.code.next : 'P0001'
    @project.start_date = Date.today
    @project.status = 'new'
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
        @project.events.create!(state: 'open', user_id: current_user.id)
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
        format.html { redirect_to @project, flash: {error: 'Project not deleted. Maybe sales or purchase orders exist'} }
      end
    end
  end

  def close
    @project = current_resource
    respond_to do |format|
      if @project.close(current_user)
        format.html { redirect_to @project, flash: {success: "project #{@project.code} closed"}}
      else
        format.html { redirect_to @project, flash: {error: @project.errors.full_messages.join(' ')} }
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
  def sort_column
    %w[projects.code projects.name companies.name start_date end_date status].include?(params[:sort]) ? params[:sort] : "projects.code"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
