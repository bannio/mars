require 'spec_helper'

 describe 'Sales Order' do
	describe "Issue" do
		it "is available to open orders" do
			@user = FactoryGirl.create(:user) 
	 		@user.roles = ['sales_order']
	 		login_as @user
			sales_order = create(:sales_order)
			event = create(:event, eventable_type: 'SalesOrder', 
															eventable_id: sales_order.id,
															state: 'open' )
			expect(sales_order).to be_valid
			expect(sales_order.open?).to be_true
			visit sales_order_url(sales_order)
			expect(page).to have_text('Issue Sales Order')
		end
		it "creates an issued event" do
			@user = FactoryGirl.create(:user) 
	 		@user.roles = ['sales_order']
	 		login_as @user
			sales_order = create(:sales_order)
			sales_order_line = create(:sales_order_line, sales_order_id: sales_order.id)
			event = create(:event, eventable_type: 'SalesOrder', 
															eventable_id: sales_order.id,
															state: 'open' )
			put issue_sales_order_url(sales_order.id)
			# visit sales_order_url(sales_order)
			# click_link 'Issue Sales Order'
			# expect(Event.count).to change_by(+1) 
			expect(Event.last.state).to eq('issued')
		end
		it "removes the edit button" do
			@user = FactoryGirl.create(:user) 
	 		@user.roles = ['sales_order']
	 		login_as @user
			sales_order = create(:sales_order)
			event = create(:event, eventable_type: 'SalesOrder', 
															eventable_id: sales_order.id,
															state: 'issued' )
			visit sales_order_url(sales_order)
			expect(page).not_to have_text('Edit')
		end
		it "displays the email form" do
			@user = FactoryGirl.create(:user) 
	 		@user.roles = ['sales_order']
	 		login_as @user
			sales_order = create(:sales_order)
			event = create(:event, eventable_type: 'SalesOrder', 
															eventable_id: sales_order.id,
															state: 'open' )
			visit sales_order_path(sales_order)
			click_link 'Issue Sales Order'
			# confirm_dialog
			expect(current_path).to eq(new_email_path)
		end
	end
end