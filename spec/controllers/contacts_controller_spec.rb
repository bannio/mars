require 'spec_helper'

describe ContactsController do
  
  def valid_attributes
    { name: 'My Contact',
      job_title: 'My job',
      company_id: 1,
      address_id: 1
   }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContactesController. Be sure to keep this updated too.
  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}
  end

  before do
        user = double('user')
        request.env['warden'].stub :authenticate! => user
        controller.stub :current_user => user
        user.stub(:has_role?) do |role|
          if role == 'company'
            true
          end
        end
  end

  describe "GET index" do
    it "assigns all contacts as @contacts" do
      contact = Contact.create! valid_attributes
      get :index, {}, valid_session
      assigns(:contacts).should eq([contact])
    end
  end

    describe "GET show" do
      it "assigns the requested contact as @contact" do
        contact = Contact.create! valid_attributes
        get :show, {:id => contact.to_param}, valid_session
        assigns(:contact).should eq(contact)
      end
    end

    describe "GET new" do
      it "assigns a new contact as @contact" do
        get :new, {}, valid_session
        assigns(:contact).should be_a_new(Contact)
      end
    end

    describe "GET edit" do
      it "assigns the requested contact as @contact" do
        contact = Contact.create! valid_attributes
        get :edit, {:id => contact.to_param}, valid_session
        assigns(:contact).should eq(contact)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Contact" do
          expect {
            post :create, {:contact => valid_attributes}, valid_session.merge(return_to: contacts_path)
          }.to change(Contact, :count).by(1)
        end

        it "assigns a newly created contact as @contact" do
          post :create, {:contact => valid_attributes}, valid_session.merge(return_to: contacts_path)
          assigns(:contact).should be_a(Contact)
          assigns(:contact).should be_persisted
        end

        it "redirects to the calling page on create" do
          post :create, {:contact => valid_attributes}, valid_session.merge(return_to: contacts_path)
          response.should_not redirect_to(Contact.last)
          response.should redirect_to(contacts_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved contact as @contact" do
          # Trigger the behavior that occurs when invalid params are submitted
          Contact.any_instance.stub(:save).and_return(false)
          post :create, {:contact => { "company_id" => "invalid value" }}, valid_session
          assigns(:contact).should be_a_new(Contact)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Contact.any_instance.stub(:save).and_return(false)
          post :create, {:contact => { "company_id" => "invalid value" }}, valid_session
          response.should render_template("new")
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
          Contact.any_instance.should_receive(:update_attributes).with({ "company_id" => "1" })
          put :update, {:id => contact.to_param, :contact => { "company_id" => "1" }}, valid_session
        end

        it "assigns the requested contact as @contact" do
          contact = Contact.create! valid_attributes
          put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session.merge(return_to: contacts_path)
          assigns(:contact).should eq(contact)
        end

        it "redirects to the calling page" do
          contact = Contact.create! valid_attributes
          # session[:return_to] = contacts_url
          visit contacts_path
          put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session.merge(return_to: contacts_path)
          response.should_not redirect_to(contact)
          response.should redirect_to(contacts_path)
        end
      end

      describe "with invalid params" do
        it "assigns the contact as @contact" do
          contact = Contact.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Contact.any_instance.stub(:save).and_return(false)
          put :update, {:id => contact.to_param, :contact => { "company_id" => "invalid value" }}, valid_session
          assigns(:contact).should eq(contact)
        end

        it "re-renders the 'edit' template" do
          contact = Contact.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Contact.any_instance.stub(:save).and_return(false)
          put :update, {:id => contact.to_param, :contact => { "company_id" => "invalid value" }}, valid_session
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      
      before do
        controller.request.stub(:referer).and_return contacts_url
      end
      
      it "destroys the requested contact" do
        contact = Contact.create! valid_attributes
        expect {
          delete :destroy, {:id => contact.to_param}, valid_session
        }.to change(Contact, :count).by(-1)
      end

      it "redirects to the calling page" do
        contact = Contact.create! valid_attributes
        delete :destroy, {:id => contact.to_param}, valid_session
        response.should redirect_to(contacts_url)
      end
    end

  end
  