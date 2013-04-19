require 'spec_helper'

describe QuotationsController do

  # This should return the minimal set of attributes required to create a valid
  # Quotation. As you add validations to Quotation, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { name: "MyQuoteString",
      customer_id: 1,
      project_id: 1,
      supplier_id: 1
       }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuotationsController. Be sure to keep this updated too.
  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}
  end
  
  before do
    user = double('user')
    request.env['warden'].stub :authenticate! => user
    controller.stub :current_user => user
    user.stub(:has_role?) do |role|
      if role == 'sales_quote'
        true
      end
    end
    @company = FactoryGirl.create(:company)                           # so company 1 exists for valid attributes
    # @customer = @company
    @project = @company.projects.create(code: 'P001', name: 'my project')
    request.env["HTTP_REFERER"] = root_url  # for redirects to return_to path
  end

  describe "GET index" do
    it "assigns all quotations as @quotations" do
      quotation = Quotation.create! valid_attributes
      get :index, {}, valid_session
      assigns(:quotations).should eq([quotation])
    end
  end

  describe "GET show" do
    it "assigns the requested quotation as @quotation" do
      quotation = Quotation.create! valid_attributes
      get :show, {:id => quotation.to_param}, valid_session
      assigns(:quotation).should eq(quotation)
    end
  end

  describe "GET new" do
    it "assigns a new quotation as @quotation" do
      get :new, {customer_id: 1}, valid_session
      assigns(:quotation).should be_a_new(Quotation)
    end
  end

  describe "GET edit" do
    it "assigns the requested quotation as @quotation" do
      quotation = Quotation.create! valid_attributes
      get :edit, {:id => quotation.to_param}, valid_session
      assigns(:quotation).should eq(quotation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Quotation" do
        expect {
          post :create, {:quotation => valid_attributes}, valid_session
        }.to change(Quotation, :count).by(1)
      end

      it "assigns a newly created quotation as @quotation" do
        post :create, {:quotation => valid_attributes}, valid_session
        assigns(:quotation).should be_a(Quotation)
        assigns(:quotation).should be_persisted
      end

      it "redirects to the created quotation" do
        post :create, {:quotation => valid_attributes}, valid_session
        response.should redirect_to(Quotation.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved quotation as @quotation" do
        # Trigger the behavior that occurs when invalid params are submitted
        Quotation.any_instance.stub(:save).and_return(false)
        post :create, {:quotation => { "name" => "invalid value" }}, valid_session
        assigns(:quotation).should be_a_new(Quotation)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Quotation.any_instance.stub(:save).and_return(false)
        post :create, {:quotation => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
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
        Quotation.any_instance.should_receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => quotation.to_param, :quotation => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested quotation as @quotation" do
        quotation = Quotation.create! valid_attributes
        put :update, {:id => quotation.to_param, :quotation => valid_attributes}, valid_session
        assigns(:quotation).should eq(quotation)
      end

      it "redirects to the quotation" do
        quotation = Quotation.create! valid_attributes
        put :update, {:id => quotation.to_param, :quotation => valid_attributes}, valid_session
        response.should redirect_to(quotation)
      end
    end

    describe "with invalid params" do
      it "assigns the quotation as @quotation" do
        quotation = Quotation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Quotation.any_instance.stub(:save).and_return(false)
        put :update, {:id => quotation.to_param, :quotation => { "name" => "invalid value" }}, valid_session
        assigns(:quotation).should eq(quotation)
      end

      it "re-renders the 'edit' template" do
        quotation = Quotation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Quotation.any_instance.stub(:save).and_return(false)
        put :update, {:id => quotation.to_param, :quotation => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested quotation" do
      quotation = Quotation.create! valid_attributes
      expect {
        delete :destroy, {:id => quotation.to_param}, valid_session
      }.to change(Quotation, :count).by(-1)
    end

    it "redirects to the calling page" do
      quotation = Quotation.create! valid_attributes
      delete :destroy, {:id => quotation.to_param}, valid_session
      response.should redirect_to(root_url)
    end
  end

end
