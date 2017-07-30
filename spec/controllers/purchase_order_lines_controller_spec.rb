require 'spec_helper'

describe PurchaseOrderLinesController, :type => :controller do

  def valid_attributes
    { category: '',
      name: 'My string',
      purchase_order_id: 1,
      quantity: 1,
      unit_price: 9.99,
      position: 1
       }
  end

  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}
  end

  before do
    user = instance_double('user', :id => 1)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    allow(user).to receive(:has_role?).and_return(true)
    request.env['HTTP_REFERER'] = '/'

    @purchase_order = FactoryGirl.create(:purchase_order)   # so purchase_order exists for valid attributes
    params = {}
    params[:purchase_order] = @purchase_order
    allow(controller).to receive(:session).and_return({return_to: purchase_orders_path})  # for redirects to return_to path
  end

  describe "POST sort" do
    it "sorts by an array of ids" do
      @line1 = PurchaseOrderLine.create! valid_attributes.merge({position: 1, purchase_order_id: @purchase_order.id})
      @line2 = PurchaseOrderLine.create! valid_attributes.merge({position: 2, purchase_order_id: @purchase_order.id})
      @line3 = PurchaseOrderLine.create! valid_attributes.merge({position: 3, purchase_order_id: @purchase_order.id})
      @line4 = PurchaseOrderLine.create! valid_attributes.merge({position: 4, purchase_order_id: @purchase_order.id})

      # po_lines = ["4","3","1","2"]
      po_lines = [@line4.id, @line3.id, @line1.id, @line2.id]

      post :sort, params: {purchase_order_line: po_lines}, session: valid_session
      @line1.reload
      @line2.reload
      @line3.reload
      @line4.reload

      expect(@line1.position).to eq(3)
      expect(@line2.position).to eq(4)
      expect(@line3.position).to eq(2)
      expect(@line4.position).to eq(1)
    end
  end
end
