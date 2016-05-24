require 'spec_helper'

describe PurchaseOrdersController, :type => :controller do

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
    # user = double('user')
    # request.env['warden'].stub :authenticate! => user
    # controller.stub :current_user => user
    # user.stub(:has_role?) do |role|
    #   if role == 'purchase'
    #     true
    #   end
    # end
		user = instance_double('user', :id => 1)
		allow(request.env['warden']).to receive(:authenticate!).and_return(user)
		allow(controller).to receive(:current_user).and_return(user)
		allow(user).to receive(:has_role?).and_return(true)
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

  describe 'POST copy line' do
    before do
      @po = create(:purchase_order, status: 'open')
      @po_line = @po.purchase_order_lines.create(valid_attributes)
    end

    it "creates a new line" do
      expect {
        post :copy_line, {id: @po.to_param, line_id: @po_line.to_param}, valid_session
      }.to change(@po.purchase_order_lines, :count).by(1)
    end
    it "clears the quanity to zero" do
      post :copy_line, {id: @po.to_param, line_id: @po_line.to_param}, valid_session
      expect(PurchaseOrderLine.last.quantity).to eq(0)
    end
    it "keeps the unit_price" do
      post :copy_line, {id: @po.to_param, line_id: @po_line.to_param}, valid_session
      expect(PurchaseOrderLine.last.unit_price).to eq(9.99)
    end

  end
end
