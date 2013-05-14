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
			# expect(sales_order.open?).to be_true
			# visit sales_order_url(sales_order)
			# expect(page).to have_text('Issue Sales Order')
		end
		it "creates an issued event"
		it "removes the edit button"
		it "displays the email form"
	end
end