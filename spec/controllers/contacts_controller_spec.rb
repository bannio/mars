require 'spec_helper'

describe ContactsController, :type => :controller do

  let(:company) { create(:company) }
  let(:address) { create(:address)}

  def valid_attributes
    { name: 'My Contact',
      job_title: 'My job',
      company_id: company.id,
      address_id: address.id
   }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContactesController. Be sure to keep this updated too.
  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}.merge(return_to: contacts_path)
  end

  before do
    user = double('user')
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    allow(user).to receive(:has_role?).and_return(true)
      # user.stub(:has_role?) do |role|
      #   if role == 'company'
      #     true
      #   end
      # end
      # params = {}
      # params[:company] = company
  end

  describe "GET" do
    it "assigns all contacts as @contacts" do
      contact = Contact.create! valid_attributes
      get :index, params: {}
      expect(assigns(:contacts)).to eq([contact])
    end
  end

    describe "GET show" do
      it "assigns the requested contact as @contact" do
        contact = Contact.create! valid_attributes
        get :show, params: {company_id: company, :id => contact.to_param}, session: valid_session
        expect(assigns(:contact)).to eq(contact)
      end
    end

    describe "GET new" do
      it "assigns a new contact as @contact" do
        get :new, params: {company_id: company}, session: valid_session
        expect(assigns(:contact)).to be_a_new(Contact)
      end
    end

    describe "GET edit" do
      it "assigns the requested contact as @contact" do
        contact = Contact.create! valid_attributes
        get :edit, params: {company_id: company,:id => contact.to_param}, session: valid_session
        expect(assigns(:contact)).to eq(contact)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Contact" do
          expect {
            post :create, params: {company_id: company, :contact => valid_attributes}, session: valid_session
          }.to change(Contact, :count).by(1)
        end

        it "assigns a newly created contact as @contact" do
          post :create, params: {company_id: company, :contact => valid_attributes}, session: valid_session
          expect(assigns(:contact)).to be_a(Contact)
          expect(assigns(:contact)).to be_persisted
        end

        it "redirects to the calling page on create" do
          post :create, params: {company_id: company, :contact => valid_attributes}, session: valid_session
          expect(response).to redirect_to(contacts_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved contact as @contact" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Contact).to receive(:save).and_return(false)
          post :create, params: {company_id: company, :contact => { "company_id" => "invalid value" }}, session: valid_session
          expect(assigns(:contact)).to be_a_new(Contact)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Contact).to receive(:save).and_return(false)
          post :create, params: {company_id: company, :contact => { "company_id" => "invalid value" }}, session: valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested contact" do
          contact = Contact.create! valid_attributes
          # Assuming there are no other contacts in the database, this
          # specifies that the Contact created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          allow_any_instance_of(Contact).to receive(:update_attributes).with({ "company_id" => "1" })
          put :update, params: {company_id: company, :id => contact.to_param, :contact => { "company_id" => "1" }}, session: valid_session
        end

        it "assigns the requested contact as @contact" do
          contact = Contact.create! valid_attributes
          put :update, params: {company_id: company, :id => contact.to_param, :contact => valid_attributes}, session: valid_session
          expect(assigns(:contact)).to eq(contact)
        end

        it "redirects to the calling page" do
          contact = Contact.create! valid_attributes.merge(company_id: company.id)
          # session[:return_to] = contacts_url
          visit company_contacts_path(company)
          put :update, params: {company_id: company, :id => contact.to_param, :contact => valid_attributes}, session: valid_session
          expect(response).to redirect_to(contacts_path)
        end
      end

      describe "with invalid params" do
        it "assigns the contact as @contact" do
          contact = Contact.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Contact).to receive(:save).and_return(false)
          put :update, params: {company_id: company, :id => contact.to_param, :contact => { "company_id" => "invalid value" }}, session: valid_session
          expect(assigns(:contact)).to eq(contact)
        end

        it "re-renders the 'edit' template" do
          contact = Contact.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          allow_any_instance_of(Contact).to receive(:save).and_return(false)
          put :update, params: {company_id: company, :id => contact.to_param, :contact => { "company_id" => "invalid value" }}, session: valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do

      before do
        request.env['HTTP_REFERER'] = contacts_path
      end

      it "destroys the requested contact" do
        contact = Contact.create! valid_attributes
        expect {
          delete :destroy, params: {company_id: company, :id => contact.to_param}, session: valid_session
        }.to change(Contact, :count).by(-1)
      end

      it "redirects to the calling page" do
        contact = Contact.create! valid_attributes
        delete :destroy, params: {company_id: company, :id => contact.to_param}, session: valid_session
        expect(response).to redirect_to(contacts_path)
      end
    end

  end