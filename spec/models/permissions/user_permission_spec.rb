require "spec_helper"

describe Permissions::UserPermission do
  describe "with no roles assigned" do
    let(:user) { create(:user) }
    subject { Permissions.permission_for(user) }
    
    it "allows" do
      should allow(:home, :index)
      should_not allow(:companies, :index)
      should allow('users/registrations', :edit)
      should allow('users/registrations', :update)
    end
  end
  describe "with just company role" do
    let(:user) { create(:user, roles_mask: 2) }
    subject { Permissions.permission_for(user) }
    
    it "allows" do
      should allow(:home, :index)
      should allow(:companies, :index)
      should allow(:companies, :show)
      should allow(:companies, :new)
      should allow(:companies, :create)
      should allow(:companies, :edit)
      should allow(:companies, :update)
      should allow(:companies, :destroy)
      should_not allow(:users, :index)
      should allow_param(:company, :name)
      should_not allow_param(:user, :name)
      should allow('users/registrations', :edit)
      should allow('users/registrations', :update)
    end
  end
end