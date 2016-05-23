require 'spec_helper'

 describe 'Sales Order', :type => :request do
	describe 'Issue' do
		# self.use_transactional_fixtures = false # may need this in conjunction with js: true and selenium

    before :all do
      # @controller = SalesOrdersController.new
      puts "before all..."
    end
    before :each do
      # the following is required because the name of the controller cannot be deduced from
      # the name of this test
      @controller = SalesOrdersController.new

			@user = FactoryGirl.create(:user)
	 		@user.roles = ['sales_order']
	 		login_as @user

			@sales_order = create(:sales_order)
			@event = create(:event, eventable_type: 'SalesOrder',
															eventable_id: @sales_order.id,
															state: 'open' )
			sales_order_line = {name: '1', description: 'test', quantity: 1, unit_price: 10.00}
			@sales_order.sales_order_lines.create(sales_order_line)
			@supplier_address = FactoryGirl.create(:address, company_id: @sales_order.supplier.id)
			# @sales_order.stub(:create_pdf).and_return(true)
      allow_any_instance_of(SalesOrder).to receive(:create_pdf).and_return(true)
		end

		it "is available to open orders" do
			expect(@sales_order).to be_valid
			expect(@sales_order.open?).to be true
			visit sales_order_path(@sales_order)
			expect(page).to have_text('Issue Sales Order')
		end
		it "creates an issued event" do
			put issue_sales_order_path(@sales_order)
			expect(Event.last.state).to eq('issued')
		end
		it "removes the edit button" do
			put issue_sales_order_path(@sales_order)
			visit sales_order_path(@sales_order)
			expect(page).not_to have_text('Edit')
		end
		it "displays the email form" do
			put issue_sales_order_path(@sales_order)
			expect(response).to redirect_to(new_email_path params: {id: @sales_order.id, type: 'SalesOrder'})
		end
	end
end
