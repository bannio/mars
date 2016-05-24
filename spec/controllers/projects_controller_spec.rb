require 'spec_helper'

describe ProjectsController, :type => :controller do

  def valid_attributes
    { code: 'P1',
      name: "MyProject",
      company_id: 1
    }
  end

  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}
  end

  before do
        # user = double('user')
        # request.env['warden'].stub :authenticate! => user
        # controller.stub :current_user => user
        # user.stub id: 1
        # user.stub(:has_role?) do |role|
        #   if role == 'project'
        #     true
        #   end
        # end
        user = instance_double('user', :id => 1)
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive(:has_role?).and_return(true)

        @company = FactoryGirl.create(:company)                           # so company 1 exists for valid attributes
        # controller.stub(:session).and_return({return_to: projects_path})  # for redirects to return_to path
        allow(controller).to receive(:session).and_return({return_to: projects_path})
  end

  describe "GET index" do
    it "assigns all projects as @projects" do
      project = Project.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe "GET show" do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :show, {:id => project.to_param}, valid_session
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      get :new, {}, valid_session
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :edit, {:id => project.to_param}, valid_session
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, {:project => valid_attributes}, valid_session
        }.to change(Project, :count).by(1)
      end

      it "assigns a newly created project as @project" do
        post :create, {:project => valid_attributes}, valid_session
        expect(assigns(:project)).to be_a(Project)
        expect(assigns(:project)).to be_persisted
      end

      it "redirects to the created project" do
        post :create, {:project => valid_attributes}, valid_session
        expect(response).to redirect_to(projects_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Project).to receive(:save).and_return(false)
        post :create, {:project => { "name" => "invalid value" }}, valid_session
        expect(assigns(:project)).to be_a_new(Project)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Project).to receive(:save).and_return(false)
        post :create, {:project => { "name" => "invalid value" }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested project" do
        project = Project.create! valid_attributes
        # Assuming there are no other projects in the database, this
        # specifies that the Project created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        allow_any_instance_of(Project).to receive(:update_attributes).with({ "name" => "MyString" })
        put :update, {:id => project.to_param, :project => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested project as @project" do
        project = Project.create! valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
        expect(assigns(:project)).to eq(project)
      end

      it "redirects to the calling path" do
        project = Project.create! valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
        expect(response).to redirect_to(projects_path)
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        project = Project.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Project).to receive(:save).and_return(false)
        put :update, {:id => project.to_param, :project => { "name" => "invalid value" }}, valid_session
        expect(assigns(:project)).to eq(project)
      end

      it "re-renders the 'edit' template" do
        project = Project.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Project).to receive(:save).and_return(false)
        put :update, {:id => project.to_param, :project => { "name" => "invalid value" }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect {
        delete :destroy, {:id => project.to_param}, valid_session
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      project = Project.create! valid_attributes
      delete :destroy, {:id => project.to_param}, valid_session
      expect(response).to redirect_to(projects_path)
    end

    it "does not destroy when a sales_order exists" do
      project = Project.create! valid_attributes
      sales_order = create(:sales_order, project_id: project.id)
      project.reload
      expect {
        delete :destroy, {:id => project.to_param}, valid_session
      }.to_not change(Project, :count)
    end
    it "does not destroy when a purchase_order exists" do
      project = Project.create! valid_attributes
      purchase_order = create(:purchase_order, project_id: project.id)
      project.reload
      expect {
        delete :destroy, {:id => project.to_param}, valid_session
      }.to_not change(Project, :count)
    end
    it "does not destroy when a quotation exists" do
      project = Project.create! valid_attributes
      quotation = create(:quotation, project_id: project.id)
      project.reload
      expect {
        delete :destroy, {:id => project.to_param}, valid_session
      }.to_not change(Project, :count)
    end
  end

end
