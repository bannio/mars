class EmailsController < ApplicationController


  def index
    @emails = Email.search(params[:search])
  end

  def show
    @email = Email.find(params[:id])
  end
  
  def new
    @email = Email.new
    @email.emailable_type = params[:type]
    @email.emailable_id = params[:id]
    @user = current_user
  end

  def download_attachment
    @email = Email.find(params[:id])
    send_file @email.attachment,type: "application/pdf",
                                disposition: "inline"
  end
  
  def create
    @email = Email.new(params[:email])
    
    respond_to do |format|
      if @email.save
        format.html { redirect_to @email.emailable, flash: { success: 'Email was successfully created.'} }
      else
        @user = current_user
        format.html { render action: "new" }
        # format.html { render action: "new", params: params[:email] }
      end
    end
  end

  private


end
