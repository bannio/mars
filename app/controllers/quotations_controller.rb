class QuotationsController < ApplicationController

  def import
    @quotation = current_resource
    @quotation.import(params[:file])
    redirect_to :back, flash: {success: 'Lines were successfully imported'}
  end
  
  def index
    @quotations = Quotation.all

    respond_to do |format|
      format.html 
    end
  end

  def show
    @quotation = current_resource
    # @line = @quotation.quotation_lines.new
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SalesQuotePdf.new(@quotation, view_context)
        send_data pdf.render, filename: "#{@quotation.code}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  # GET /quotations/new
  # GET /quotations/new.json
  def new
    @quotation = Quotation.new
    @quotation.code = Quotation.last ? Quotation.last.code.next : 'SQ0001'
    @quotation.issue_date = Date.today
    @customer = Company.find(params[:customer_id])
    @quotation.customer_id = @customer.id
    @quotation.project_id = params[:project_id]
    @quotation.supplier_id = 2                          # hard coded! To be changed.

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quotation }
    end
  end

  # GET /quotations/1/edit
  def edit
    @quotation = current_resource
    @customer = Company.find(@quotation.customer_id)
  end

  # POST /quotations
  # POST /quotations.json
  def create
    @quotation = Quotation.new(params[:quotation])

    respond_to do |format|
      if @quotation.save
        format.html { redirect_to @quotation, notice: 'Quotation was successfully created.' }
        format.json { render json: @quotation, status: :created, location: @quotation }
      else
        format.html { render action: "new" }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotations/1
  # PATCH/PUT /quotations/1.json
  def update
    @quotation = current_resource

    respond_to do |format|
      if @quotation.update_attributes(params[:quotation])
        format.html { redirect_to @quotation, notice: 'Quotation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation = current_resource
    @quotation.destroy

    respond_to do |format|
      format.html { redirect_to :back } # destroy link on company show page NOT on quotation show
      format.json { head :no_content }
    end
  end

  private

  def current_resource
    @current_resource ||= Quotation.find(params[:id]) if params[:id]
  end
end
