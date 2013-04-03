class AddressesController < ApplicationController
  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @addresses }
    end
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
    @address = current_resource

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @address }
    end
  end

  # GET /addresses/new
  # GET /addresses/new.json
  def new
    @address = Address.new
    session[:return_to] = request.referer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @address }
    end
  end

  # GET /addresses/1/edit
  def edit
    @address = current_resource
    session[:return_to] = request.referer
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(params[:address])

    respond_to do |format|
      if @address.save
        format.html { redirect_to session[:return_to], flash: {success: 'Address was successfully created.'} }
        format.json { render json: @address, status: :created, location: @address }
      else
        format.html { render action: "new" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    @address = current_resource

    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html { redirect_to session[:return_to], flash: {success: 'Address was successfully updated.'} }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address = Address.find(params[:id])
    session[:return_to] = request.referer

    respond_to do |format|
      if @address.destroy
        format.html { redirect_to session[:return_to] }
        format.json { head :no_content }
      else
        format.html { redirect_to session[:return_to], flash: {error: 'Not able to delete address, maybe in use by a contact'} }
      end
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    # def address_params
    #       params.require(:address).permit(:body, :company_id, :name, :post_code)
    #     end
    
    def current_resource
      @current_resource ||= Address.find(params[:id]) if params[:id]
    end
end
