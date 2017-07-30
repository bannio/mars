class UsersController < ApplicationController
  def index
    @users = User.order(:name)
  end

  def show
    # current_resource used to provide parameter level authorization
    @user = current_resource
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_resource
  end

  def create
    # @user = User.new(params[:user].permit(:name, :email, :full_name, :password, :password_confirmation, :roles))
    @user = User.new(params.require(:user).permit(:name, :email, :full_name, :password, :password_confirmation, :roles))

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_resource
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @User.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = current_resource
    @user.destroy
    redirect_to users_path
  end

  private

  def current_resource
    @current_resource ||= User.find(params[:id]) if params[:id]
  end
end
