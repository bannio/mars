class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authorize

  delegate :allow?, to: :current_permission
  helper_method :allow?

  delegate :allow_param?, to: :current_permission
  helper_method :allow_param?

private

  def current_permission
    @current_permission ||= Permissions.permission_for(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    unless params[:controller] == 'devise/sessions'
      if current_permission.allow?(params[:controller], params[:action], current_resource)
        current_permission.permit_params! params
      else
        redirect_to root_url, alert: "Not authorised."
      end
    end
  end
end
