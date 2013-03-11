# app/controllers/users/registrations_controller.rb

class Users::RegistrationsController < Devise::RegistrationsController
  def resource_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
  private :resource_params
end