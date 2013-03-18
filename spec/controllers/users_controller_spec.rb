require 'spec_helper'

describe UsersController do
  
  before do 
        user = double('user')
        request.env['warden'].stub :authenticate! => user
        controller.stub :current_user => user
        user.stub :has_role? => true 
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      get 'show', {:id => user.to_param}
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      get 'edit', {:id => user.to_param}
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      user = FactoryGirl.build(:user)
      get 'create', {:id => user.to_param}
      response.should be_success
    end
  end

  describe "DELETE 'destroy'" do
    it "destroys the requested user" do
      user = FactoryGirl.create(:user)
      expect{
        delete 'destroy', {:id => user.to_param}
      }.to change(User, :count).by(-1)
    end
  end

end
