require 'spec_helper'

describe PurchaseOrdersController do
	def valid_session
	    {"warden.user.user.key" => session["warden.user.user.key"]}.merge(return_to: home_index_path)
	end

	before do
      user = double('user')
      request.env['warden'].stub :authenticate! => user
      controller.stub :current_user => user
      user.stub(:has_role?) do |role|
        if role == 'purchase'
          true
        end
      end
	end

	describe 'GET #index' do
		it "populates a list of current POs" do
			purchase_order = create(:purchase_order, status: 'open')
			get :index, {}, valid_session
			expect(assigns(:purchase_orders)).to match_array [purchase_order]
		end
		it "ignores paid POs" do
			purchase_order = create(:purchase_order, status: 'paid')
			get :index, {}, valid_session
			expect(assigns(:purchase_orders)).to match_array []
		end
		it 'renders the index view' do
			get :index, {}, valid_session
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do
		
	end
end