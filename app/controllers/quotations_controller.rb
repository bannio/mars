class QuotationsController < ApplicationController

  before_filter :find_quotation, except: [:new, :create, :index]
    #only: [:show, :edit, :update, :destroy, :issue, :import, :reopen, :convert]
  helper_method :sort_column, :sort_direction

  def import
    if params[:file]
      @quotation.import(params[:file])
      redirect_to :back, flash: {success: 'Lines were successfully imported'}
    else
      redirect_to :back, flash: {error: 'You must select a file before import'}
    end
    
  end
  
  def index
    @quotations = Quotation.current.includes(:project, :customer).order(sort_column + " " + sort_direction)
    @quotations = @quotations.search(params[:search])

    respond_to do |format|
      format.html 
    end
  end

  def show
    flash[:notice] = params[:warning] if params[:warning]
    # @line = @quotation.quotation_lines.new
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SalesQuotePdf.new(@quotation)
        send_data pdf.render, filename: "#{@quotation.code}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
      format.csv do
        send_data @quotation.to_csv
      end
    end
  end

  def new
    @quotation = Quotation.new
    @quotation.code = Quotation.last ? Quotation.last.code.next : 'SQ0001'
    @quotation.customer = Company.find(params[:customer_id])
    @quotation.project_id = params[:project_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quotation }
    end
  end

  def edit
    @customer = Company.find(@quotation.customer_id)
  end

  def create
    @quotation = Quotation.new(params[:quotation])

    respond_to do |format|
      if @quotation.save
        @quotation.events.create!(state: 'open', user_id: current_user.id)
        format.html { redirect_to @quotation, flash: {success: 'Quotation was successfully created.'} }
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
  
  def issue
    respond_to do |format|
      if @quotation.issue(current_user) 
        @quotation.update_attributes(issue_date: Date.today, status: 'issued')
        @quotation.create_pdf
        format.html { redirect_to new_email_path params: {type: 'Quotation',
                                                          id: @quotation.id} , 
                                flash: {success: 'Quotation status changed to issued'} }
      else
        format.html { redirect_to @quotation, flash: {error: @quotation.errors.full_messages.join(' ')} }
      end
    end
  end
  
  def reopen
    respond_to do |format|
      if @quotation.reopen(current_user) 
        @quotation.update_attributes(status: 'open')
        format.html { redirect_to @quotation, flash: {success: 'Quotation status changed to open'} }
      else
        format.html { redirect_to @quotation, flash: {error: @quotation.errors.full_messages.join(' ')} }
      end
    end
  end

  def convert
    respond_to do |format|
      # create a new sales order based on the quotation and change status of quotation to 'ordered'
      if @quotation.convert(current_user)
        @quotation.update_attributes(status: 'ordered')
        @quotation.clone_as_sales_order
        format.html { redirect_to @quotation.customer, flash: {success: 'New Sales Order created'}}
      else
        format.html { redirect_to @quotation, flash: {error: @quotation.errors.full_messages.join(' ')} }
      end
    end
  end

  def cancel
    respond_to do |format|
      # change status of quotation to 'cancelled'
      if @quotation.cancel(current_user)
        @quotation.update_attributes(status: 'cancelled')
        format.html { redirect_to @quotation.customer, flash: {success: "Quotation #{@quotation.code} cancelled"}}
      else
        format.html { redirect_to @quotation, flash: {error: @quotation.errors.full_messages.join(' ')} }
      end
    end
    
  end

  def destroy
    @quotation.destroy

    respond_to do |format|
      format.html { redirect_to :back } # destroy link on company show page NOT on quotation show
      format.json { head :no_content }
    end
  end

  def list_emails
    @emails = @quotation.emails
    render template: 'emails/index' 
  end

  def list_events
    @events = @quotation.events
    render template: 'events/index' 
  end

  private

  def find_quotation
    @quotation = Quotation.find(params[:id]) if params[:id]
  end

  def sort_column
     %w[quotations.code quotations.name projects.code companies.name issue_date total status].include?(params[:sort]) ? params[:sort] : "quotations.code"
   end

   def sort_direction
     %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
   end

end
