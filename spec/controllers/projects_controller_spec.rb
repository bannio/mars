require 'spec_helper'

describe ProjectsController, :type => :controller do

  let(:company) { create(:company) }
  let(:user) { create(:user) }

  def valid_attributes
    { code: 'P1',
      name: "MyProject",
      company_id: company.id
    }
  end

  before do
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive(:has_role?).and_return(true)
        allow(controller).to receive(:session).and_return({return_to: projects_path})
  end

  describe "GET index" do
    it "assigns all projects as @projects" do
      project = Project.create! valid_attributes
      get :index, params: {}
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe "GET show" do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :show, params: {:id => project.to_param}
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      get :new, params: {}
      expect(assigns(:project)).to be_a_new(Project)
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :edit, params: {:id => project.to_param}
      expect(assigns(:project)).to eq(project)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, params: {project: valid_attributes}
        }.to change(Project, :count).by(1)
      end

      it "assigns a newly created project as @project" do
        post :create, params: {:project => valid_attributes}
        expect(assigns(:project)).to be_a(Project)
        expect(assigns(:project)).to be_persisted
      end

      it "redirects to the created project" do
        post :create, params: {:project => valid_attributes}
        expect(response).to redirect_to(projects_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Project).to receive(:save).and_return(false)
        post :create, params: {:project => { "name" => "invalid value" }}
        expect(assigns(:project)).to be_a_new(Project)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Project).to receive(:save).and_return(false)
        post :create, params: {:project => { "name" => "invalid value" }}
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
        put :update, params: {:id => project.to_param, :project => { "name" => "MyString" }} #, valid_session
      end

      it "assigns the requested project as @project" do
        project = Project.create! valid_attributes
        put :update, params: {:id => project.to_param, :project => valid_attributes}
        expect(assigns(:project)).to eq(project)
      end

      it "redirects to the calling path" do
        project = Project.create! valid_attributes
        put :update, params: {:id => project.to_param, :project => valid_attributes}
        expect(response).to redirect_to(projects_path)
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        project = Project.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Project).to receive(:save).and_return(false)
        put :update, params: {:id => project.to_param, :project => { "name" => "invalid value" }}
        expect(assigns(:project)).to eq(project)
      end

      it "re-renders the 'edit' template" do
        project = Project.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Project).to receive(:save).and_return(false)
        put :update, params: {:id => project.to_param, :project => { "name" => "invalid value" }}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect {
        delete :destroy, params: {:id => project.to_param}
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      project = Project.create! valid_attributes
      delete :destroy, params: {:id => project.to_param}
      expect(response).to redirect_to(projects_path)
    end

    it "does not destroy when a sales_order exists" do
      project = Project.create! valid_attributes
      sales_order = create(:sales_order, project_id: project.id)
      project.reload
      expect {
        delete :destroy, params: {:id => project.to_param}
      }.to_not change(Project, :count)
    end
    it "does not destroy when a purchase_order exists" do
      project = Project.create! valid_attributes
      purchase_order = create(:purchase_order, project_id: project.id)
      project.reload
      expect {
        delete :destroy, params: {:id => project.to_param}
      }.to_not change(Project, :count)
    end
    it "does not destroy when a quotation exists" do
      project = Project.create! valid_attributes
      quotation = create(:quotation, project_id: project.id)
      project.reload
      expect {
        delete :destroy, params: {:id => project.to_param}
      }.to_not change(Project, :count)
    end
  end

end
