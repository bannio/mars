require 'spec_helper'

describe UsersController, :type => :controller do

  # before do
  #       user = double('user')
  #       request.env['warden'].stub :authenticate! => user
  #       controller.stub :current_user => user
  #       user.stub :has_role? => true
  # end
  before do
        user = double('user')
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to  receive(:has_role?).and_return(true)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      get 'show', params: {:id => user.to_param}
      expect(response).to be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      get 'edit', params: {:id => user.to_param}
      expect(response).to be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      user = FactoryGirl.build(:user).attributes
      # get 'create', {:id => user.to_param}
      get 'create', params: {:user => user}
      expect(response).to be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "destroys the requested user" do
      user = FactoryGirl.create(:user)
      expect{
        delete 'destroy', params: {:id => user.to_param}
      }.to change(User, :count).by(-1)
    end
  end

end
