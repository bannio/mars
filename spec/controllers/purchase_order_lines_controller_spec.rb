require 'spec_helper'

describe PurchaseOrderLinesController do

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
    user = double('user')
    request.env['warden'].stub :authenticate! => user
    request.env['HTTP_REFERER'] = '/'
    controller.stub :current_user => user
    user.stub(:has_role?) do |role|
      if role == 'purchase'
        true
      end
    end
    @purchase_order = FactoryGirl.create(:purchase_order)   # so purchase_order 1 exists for valid attributes
    params = {}
    params[:purchase_order] = @purchase_order
    controller.stub(:session).and_return({return_to: purchase_orders_path})  # for redirects to return_to path
  end

  describe "POST sort" do
    it "sorts by an array of ids" do
      @line1 = PurchaseOrderLine.create! valid_attributes.merge({position: 1})
      @line2 = PurchaseOrderLine.create! valid_attributes.merge({position: 2})
      @line3 = PurchaseOrderLine.create! valid_attributes.merge({position: 3})
      @line4 = PurchaseOrderLine.create! valid_attributes.merge({position: 4})
      
      po_lines = ["4","3","1","2"]

      post :sort, {purchase_order_line: po_lines}, valid_session
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