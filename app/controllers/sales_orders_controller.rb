class SalesOrdersController < ApplicationController
	before_filter :find_sales_order, except: [:new, :create, :index ]
  helper_method :sort_column, :sort_direction

  def import
    if params[:file]
      @sales_order.import(params[:file])
      redirect_to :back, flash: {success: 'Lines were successfully imported'}
    else
      redirect_to :back, flash: {error: 'You must select a file before import'}
    end
    
  end

  def show
    flash[:notice] = params[:warning] if params[:warning]
    
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SalesOrderPdf.new(@sales_order)
        send_data pdf.render, filename: "#{@sales_order.code}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
      format.csv do
        send_data @sales_order.to_csv
      end
    end
  end

  def index
    @sales_orders = SalesOrder.current.
                    includes(:project, :customer).
                    order(sort_column + " " + sort_direction).
                    search(params[:search])
  end

	def new
	  @sales_order = SalesOrder.new
    @sales_order.code = SalesOrder.next_code
    @sales_order.customer = Company.find(params[:customer_id])
    @sales_order.project_id = params[:project_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sales_order }	
     end	
	end	

  def create
    @sales_order = SalesOrder.new(params[:sales_order])

    respond_to do |format|
      if @sales_order.save
        @sales_order.events.create!(state: 'open', user_id: current_user.id)
        format.html { redirect_to @sales_order, flash: {success: 'Sales Order was successfully created.'} }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @customer = Company.find(@sales_order.customer.id)
  end

  def update
    respond_to do |format|
      if @sales_order.update_attributes(params[:sales_order])
        format.html {redirect_to @sales_order, flash: {success: 'Sales Order successfully updated'}}
      else
        if params[:commit] == "Add"
          format.html {redirect_to @sales_order}
        else
          format.html {render action: 'edit'}
        end
      end
    end
  end

  def issue
    respond_to do |format|
      if @sales_order.issue(current_user)
        @sales_order.update_attributes(issue_date: Date.today)
        @sales_order.create_pdf
        format.html { redirect_to new_email_path params: {type: 'SalesOrder', id: @sales_order.id}}
      else
        format.html {redirect_to @sales_order, flash: {error: @sales_order.errors.full_messages.join(' ')} }
      end
    end
  end

  def reopen
    # create event to 'open' 
    # Add or increment the revision number
    # redirect to sales order which now has a new number
    respond_to do |format|
      if @sales_order.reopen(current_user)
        @sales_order.update_code
        format.html { redirect_to @sales_order, flash: {success: 'Sales order status changed to open'}}
      else
        format.html { redirect_to @sales_order, flash: {error: @sales_order.errors.full_messages.join(' ')}}
      end
    end
  end

  def accept
    respond_to do |format|
      if @sales_order.accept(current_user)
        format.html { redirect_to @sales_order, flash: {success: 'Sales order status changed to accepted'} }
      else
        format.html { redirect_to @sales_order, flash: {error: @sales_order.errors.full_messages.join(' ')}}
      end
    end
  end

  def cancel
    respond_to do |format|
      if @sales_order.cancel(current_user)
        format.html { redirect_to @sales_order, flash: {success: 'Sales order status changed to cancelled'} }
      else
        format.html { redirect_to @sales_order, flash: {error: @sales_order.errors.full_messages.join(' ')}}
      end
    end
  end

  def invoice
    respond_to do |format|
      if @sales_order.invoice(current_user)
        format.html { redirect_to @sales_order, flash: {success: 'Sales order status changed to invoiced'} }
      else
        format.html { redirect_to @sales_order, flash: {error: @sales_order.errors.full_messages.join(' ')}}
      end
    end
  end

  def paid
    respond_to do |format|
      if @sales_order.paid(current_user)
        format.html { redirect_to @sales_order, flash: {success: 'Sales order status changed to paid'} }
      else
        format.html { redirect_to @sales_order, flash: {error: @sales_order.errors.full_messages.join(' ')}}
      end
    end
  end

  def list_emails
    @emails = @sales_order.emails
    render template: 'emails/index' 
  end

  def list_events
    @events = @sales_order.events
    render template: 'events/index' 
  end

	private
	def find_sales_order
		@sales_order = SalesOrder.find(params[:id]) if params[:id]
	end

  def sort_column
     %w[sales_orders.code sales_orders.name projects.code companies.name issue_date total status].include?(params[:sort]) ? params[:sort] : "sales_orders.code"
   end

   def sort_direction
     %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
   end
end