require 'spec_helper'

describe QuotationsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Quotation. As you add validations to Quotation, be sure to
  # update the return value of this method accordingly.

  let(:customer) { create(:customer) }
  let(:project)  { create(:project) }
  let(:supplier) { create(:supplier) }
  let(:contact)  { create(:contact) }
  let(:address)  { create(:address, company_id: customer.id) }
  let(:user)     { create(:user) }

  def valid_attributes
    { name: "MyQuoteString",
      customer_id:         customer.id,
      project_id:          project.id,
      supplier_id:         supplier.id,
      contact_id:          contact.id,
      status:              'open',
      delivery_address_id: address.id,
      address_id:          address.id
       }
  end


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuotationsController. Be sure to keep this updated too.
  # def valid_session
  #   {"warden.user.user.key" => session["warden.user.user.key"]}
  # end

  before do
    # user = instance_double('user', :id => 1)
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    allow(user).to receive(:has_role?).and_return(true)
    request.env["HTTP_REFERER"] = root_path  # for redirects to return_to path
  end

  describe "GET index" do
    it "assigns all current quotations as @quotations" do
      quotation = Quotation.create! valid_attributes
      get :index, params: {}
      expect(assigns(:quotations)).to eq([quotation])
    end
  end

  describe "GET show" do
    it "assigns the requested quotation as @quotation" do
      quotation = Quotation.create! valid_attributes
      get :show, params: {:id => quotation.to_param}
      expect(assigns(:quotation)).to eq(quotation)
    end
  end

  describe "GET new" do
    it "assigns a new quotation as @quotation" do
      get :new, params: {customer_id: customer.id}
      expect(assigns(:quotation)).to be_a_new(Quotation)
    end
  end

  describe "GET edit" do
    it "assigns the requested quotation as @quotation" do
      quotation = Quotation.create! valid_attributes.merge(customer_id: customer.id)
      get :edit, params: {:id => quotation.to_param}
      expect(assigns(:quotation)).to eq(quotation)
      true
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Quotation" do
        expect {
          post :create, params: {:quotation => valid_attributes}
        }.to change(Quotation, :count).by(1)
      end

      it "assigns a newly created quotation as @quotation" do
        post :create, params: {:quotation => valid_attributes}
        expect(assigns(:quotation)).to be_a(Quotation)
        expect(assigns(:quotation)).to be_persisted
      end

      it "redirects to the created quotation" do
        post :create, params: {:quotation => valid_attributes}
        expect(response).to redirect_to(Quotation.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved quotation as @quotation" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Quotation).to receive(:save).and_return(false)
        post :create, params: {:quotation => { "name" => "invalid value" }}
        expect(assigns(:quotation)).to be_a_new(Quotation)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Quotation).to receive(:save).and_return(false)
        post :create, params: {:quotation => { "name" => "invalid value" }}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested quotation" do
        quotation = Quotation.create! valid_attributes
        # Assuming there are no other quotations in the database, this
        # specifies that the Quotation created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Quotation).to receive(:update_attributes).with({ "name" => "MyString" })
        put :update, params: {:id => quotation.to_param, :quotation => { "name" => "MyString" }}
      end

      it "assigns the requested quotation as @quotation" do
        quotation = Quotation.create! valid_attributes
        put :update, params: {:id => quotation.to_param, :quotation => valid_attributes}
        expect(assigns(:quotation)).to eq(quotation)
      end

      it "redirects to the quotation" do
        quotation = Quotation.create! valid_attributes
        put :update, params: {:id => quotation.to_param, :quotation => valid_attributes}
        expect(response).to redirect_to(quotation)
      end
    end

    describe "with invalid params" do
      it "assigns the quotation as @quotation" do
        quotation = Quotation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Quotation).to receive(:save).and_return(false)
        put :update, params: {:id => quotation.to_param, :quotation => { "name" => "invalid value" }}
        expect(assigns(:quotation)).to eq(quotation)
      end

      it "re-renders the 'edit' template" do
        quotation = Quotation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Quotation).to receive(:save).and_return(false)
        put :update, params: {:id => quotation.to_param, :quotation => { "name" => "invalid value" }}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested quotation" do
      quotation = Quotation.create! valid_attributes
      expect {
        delete :destroy, params: {:id => quotation.to_param}
      }.to change(Quotation, :count).by(-1)
    end

    it "redirects to the calling page" do
      quotation = Quotation.create! valid_attributes
      delete :destroy, params: {:id => quotation.to_param}
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST copy line' do

    def valid_line_attributes
      {name: "item",
      description: "specification",
      quantity: 1,
      unit_price: 9.99,
      total: 0,
      category: "",
      position: 1}
    end

    before do
      @quotation = create(:quotation, status: 'open')
      @quotation_line = @quotation.quotation_lines.create(valid_line_attributes)
    end

    it "creates a new line" do
      expect {
        post :copy_line, params: {id: @quotation.to_param, line_id: @quotation_line.to_param}
      }.to change(@quotation.quotation_lines, :count).by(1)
    end
    it "clears the quanity to zero" do
      post :copy_line, params: {id: @quotation.to_param, line_id: @quotation_line.to_param}
      expect(QuotationLine.last.quantity).to eq(0)
    end
    it "keeps the unit_price" do
      post :copy_line, params: {id: @quotation.to_param, line_id: @quotation_line.to_param}
      expect(QuotationLine.last.unit_price).to eq(9.99)
    end

  end

end
