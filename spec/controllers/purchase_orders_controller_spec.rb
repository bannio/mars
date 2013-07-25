require 'spec_helper'

describe PurchaseOrdersController do

	def valid_session
	    {"warden.user.user.key" => session["warden.user.user.key"]}.merge(return_to: home_index_path)
	end

  def valid_attributes
    {name: "item",
    description: "specification",
    quantity: 1,
    unit_price: 9.99,
    total: 0,
    category: "",
    position: 1}    
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

  describe 'GET #search' do
    before do
      @po = create(:purchase_order, status: 'open')
    end

    it 'renders the search view' do
      get :search, {id: @po.to_param}, valid_session
      expect(response).to render_template :search
    end
    it 'lists nothing with empty search params' do
      get :search, {id: @po.to_param, search: ''}, valid_session
      expect(assigns(:lines)).to match_array []
    end
    it 'finds lines that match search'  do
      # @po.stub(:update_total).and_return(10.0)
      po_line = @po.purchase_order_lines.create(valid_attributes.merge({description: "pattern"}))
      get :search, {search: "pattern", id: @po.to_param}, valid_session
      expect(assigns(:lines)).to match_array [po_line]
    end
  end
end