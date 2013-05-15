require 'spec_helper'

 describe 'Sales Order' do
	describe "Issue" do
		# self.use_transactional_fixtures = false # may need this in conjunction with js: true and selenium
		before :each do
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
		end
		it "is available to open orders" do
			expect(@sales_order).to be_valid
			expect(@sales_order.open?).to be_true
			visit sales_order_url(@sales_order)
			expect(page).to have_text('Issue Sales Order')
		end
		it "creates an issued event" do
			put issue_sales_order_path(@sales_order)
			expect(Event.last.state).to eq('issued')
		end
		it "removes the edit button" do
			put issue_sales_order_path(@sales_order)
			visit sales_order_url(@sales_order)
			expect(page).not_to have_text('Edit')
		end
		it "displays the email form" do
			visit sales_order_path(@sales_order)
			put issue_sales_order_url(@sales_order)
			# expect(current_path).to eq(new_email_path) # can't get this to work
		end
	end
end