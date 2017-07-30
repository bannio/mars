require 'spec_helper'

describe QuotationLinesController, :type => :controller do

  let (:quotation) { create(:quotation) }

  def valid_attributes
    { category: '',
      name: 'My string',
      quotation_id: quotation.id,
      quantity: 1,
      unit_price: 9.99,
      position: 1
       }
  end

  before do
    request.env['HTTP_REFERER'] = '/'
    user = instance_double('user', :id => 1)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    allow(user).to receive(:has_role?).and_return(true)
    allow(controller).to receive(:session).and_return({return_to: quotations_path})  # for redirects to return_to path
  end

  describe "GET show" do
    it "assigns the requested quotation_line as quotation_line" do
      quotation_line = QuotationLine.create! valid_attributes.merge(quotation_id: quotation.id)
      get :show, params: {quotation_id: quotation, quotation: quotation.id, :id => quotation_line.to_param}
      expect(assigns(:quotation_line)).to eq(quotation_line)
    end
  end

  describe "GET edit" do
    it "assigns the requested quotation_line as quotation_line" do
      quotation_line = QuotationLine.create! valid_attributes.merge(quotation_id: quotation.id)
      get :edit, params: {quotation_id: quotation, :id => quotation_line.to_param}
      expect(assigns(:quotation_line)).to eq(quotation_line)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested quotation_line" do
        quotation_line = QuotationLine.create! valid_attributes.merge(quotation_id: quotation.id)
        # Assuming there are no other quotation_lines in the database, this
        # specifies that the QuotationLine created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        allow_any_instance_of(QuotationLine).to receive(:update_attributes).with({ "name" => "MyString" })
        put :update, params: {quotation_id: quotation, :id => quotation_line.to_param, :quotation_line => { "name" => "MyString" }}
      end

      it "assigns the requested quotation_line as quotation_line" do
        quotation_line = QuotationLine.create! valid_attributes.merge(quotation_id: quotation.id)
        put :update, params: {quotation_id: quotation, :id => quotation_line.to_param, :quotation_line => valid_attributes.merge(quotation_id: quotation.id)}
        expect(assigns(:quotation_line)).to eq(quotation_line)
      end

      it "redirects to the quotation_line" do
        quotation_line = QuotationLine.create! valid_attributes.merge(quotation_id: quotation.id)
        put :update, params: {quotation_id: quotation, :id => quotation_line.to_param, :quotation_line => valid_attributes.merge(quotation_id: quotation.id)}
        expect(response).to redirect_to(quotations_path)
      end
    end

    describe "with invalid params" do
      it "assigns the quotation_line as quotation_line" do
        quotation_line = QuotationLine.create! valid_attributes.merge(quotation_id: quotation.id)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(QuotationLine).to receive(:save).and_return(false)
        put :update, params: {quotation_id: quotation, :id => quotation_line.to_param, :quotation_line => { "name" => "invalid value" }}
        expect(assigns(:quotation_line)).to eq(quotation_line)
      end

      it "re-renders the 'edit' template" do
        quotation_line = QuotationLine.create! valid_attributes.merge(quotation_id: quotation.id)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(QuotationLine).to receive(:save).and_return(false)
        put :update, params: {quotation_id: quotation,:id => quotation_line.to_param, :quotation_line => { "name" => "invalid value" }}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    it "destroys the requested quotation_line" do
      quotation_line = QuotationLine.create! valid_attributes.merge(quotation_id: quotation.id)
      expect {
        delete :destroy, params: {quotation_id: quotation, id: quotation_line.to_param}
      }.to change(QuotationLine, :count).by(-1)
    end

    it "redirects to the referer" do
      quotation_line = QuotationLine.create! valid_attributes.merge(quotation_id: quotation.id)
      delete :destroy, params: {quotation_id: quotation, id: quotation_line.to_param}
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST sort" do
    it "sorts by an array of ids" do
      @line1 = QuotationLine.create! valid_attributes.merge({position: 1, quotation_id: quotation.id})
      @line2 = QuotationLine.create! valid_attributes.merge({position: 2, quotation_id: quotation.id})
      @line3 = QuotationLine.create! valid_attributes.merge({position: 3, quotation_id: quotation.id})
      @line4 = QuotationLine.create! valid_attributes.merge({position: 4, quotation_id: quotation.id})

      # quote_lines = ["4","3","1","2"]
      quote_lines = [@line4.id,@line3.id,@line1.id,@line2.id]

      post :sort, params: {quotation_line: quote_lines}
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
