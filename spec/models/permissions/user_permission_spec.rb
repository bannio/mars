require "spec_helper"

describe Permissions::UserPermission do
  describe "with no roles assigned" do
    let(:user) { create(:user) }
    subject { Permissions.permission_for(user) }
    
    it "allows" do
      should allow(:home, :index)
      should allow(:companies, :index)
      should allow(:contacts, :index)
      should allow(:projects, :index)
      should allow(:addresses, :index)
      should allow(:quotations, :index)
      should allow(:sales_orders, :index)
      should_not allow(:companies, :edit)
      should_not allow(:addresses, :edit)
      should_not allow(:contacts, :edit)
      should_not allow(:projects, :edit)
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
  describe "with just project role" do
    let(:user) { create(:user, roles_mask: 4) }
    subject { Permissions.permission_for(user) }
    
    it "allows" do
      should allow(:home, :index)
      should allow(:projects, :index)
      should allow(:projects, :show)
      should allow(:projects, :new)
      should allow(:projects, :create)
      should allow(:projects, :edit)
      should allow(:projects, :update)
      should allow(:projects, :destroy)
      should_not allow(:users, :index)
      should allow_param(:project, :name)
      should_not allow_param(:user, :name)
      should allow('users/registrations', :edit)
      should allow('users/registrations', :update)
    end
  end
  describe "with just sales_quote role" do
    let(:user) { create(:user, roles_mask: 8) }
    subject { Permissions.permission_for(user) }
    
    it "allows" do
      should allow(:home, :index)
      should allow(:quotations, :index)
      should allow(:quotations, :show)
      should allow(:quotations, :new)
      should allow(:quotations, :create)
      should allow(:quotations, :edit)
      should allow(:quotations, :update)
      should allow(:quotations, :destroy)
      should allow(:quotation_lines, :index)
      should allow(:quotation_lines, :show)
      should allow(:quotation_lines, :new)
      should allow(:quotation_lines, :create)
      should allow(:quotation_lines, :edit)
      should allow(:quotation_lines, :update)
      should allow(:quotation_lines, :destroy)
      should allow(:quotations, :issue)
      should allow(:quotations, :import)
      should allow(:quotations, :reopen)
      should_not allow(:users, :index)
      should allow_param(:quotation, :code)
      should allow_param(:quotation, :address_id)
      should allow_param(:quotation, :delivery_address_id)
      should allow_param(:quotation, :description)
      should allow_param(:quotation, :customer_id)
      should allow_param(:quotation, :contact_id)
      should allow_param(:quotation, :issue_date)
      should allow_param(:quotation, :name)
      should allow_param(:quotation, :notes)
      should allow_param(:quotation, :project_id)
      should allow_param(:quotation, :supplier_id)
      should_not allow_param(:user, :name)
      should allow('users/registrations', :edit)
      should allow('users/registrations', :update)
    end
  end
  describe "with just sales_order role" do
    let(:user) { create(:user, roles_mask: 16) }
    subject { Permissions.permission_for(user) }
    
    it "allows" do
      should allow(:home, :index)
      should allow(:quotations, :index)
      should allow(:quotations, :show)
      should_not allow(:quotations, :new)
      should_not allow(:purchase_orders, :new)
      should_not allow(:companies, :new)
      should allow(:sales_orders, :create)
      should allow(:sales_orders, :edit)
      should allow(:sales_orders, :update)
      should allow(:sales_orders, :destroy)
      should allow(:sales_order_lines, :new)
      should allow(:sales_order_lines, :create)
      should allow(:sales_order_lines, :edit)
      should allow(:sales_order_lines, :update)
      should allow(:sales_order_lines, :destroy)
      should allow(:sales_orders, :issue)
      should allow(:sales_orders, :reopen)
      should_not allow(:users, :index)
      should allow_param(:sales_order, :code)
      should allow_param(:sales_order, :address_id)
      should allow_param(:sales_order, :delivery_address_id)
      should allow_param(:sales_order, :description)
      should allow_param(:sales_order, :customer_id)
      should allow_param(:sales_order, :contact_id)
      should allow_param(:sales_order, :issue_date)
      should allow_param(:sales_order, :name)
      should allow_param(:sales_order, :notes)
      should allow_param(:sales_order, :project_id)
      should allow_param(:sales_order, :supplier_id)
      should_not allow_param(:user, :name)
      should allow('users/registrations', :edit)
      should allow('users/registrations', :update)
    end
  end
  describe "with just purchase role" do
    let(:user) { create(:user, roles_mask: 32) }
    subject { Permissions.permission_for(user) }
    
    it "allows" do
      should allow(:home, :index)
      should allow(:quotations, :index)
      should allow(:quotations, :show)
      should_not allow(:quotations, :new)
      should_not allow(:sales_orders, :new)
      should_not allow(:companies, :new)
      should allow(:purchase_orders, :create)
      should allow(:purchase_orders, :edit)
      should allow(:purchase_orders, :update)
      should allow(:purchase_orders, :destroy)
      should allow(:purchase_order_lines, :new)
      should allow(:purchase_order_lines, :create)
      should allow(:purchase_order_lines, :edit)
      should allow(:purchase_order_lines, :update)
      should allow(:purchase_order_lines, :destroy)
      should allow(:purchase_orders, :issue)
      should allow(:purchase_orders, :reopen)
      should_not allow(:users, :index)
      should allow_param(:purchase_order, :code)
      should allow_param(:purchase_order, :address_id)
      should allow_param(:purchase_order, :delivery_address_id)
      should allow_param(:purchase_order, :description)
      should allow_param(:purchase_order, :customer_id)
      should allow_param(:purchase_order, :contact_id)
      should allow_param(:purchase_order, :issue_date)
      should allow_param(:purchase_order, :name)
      should allow_param(:purchase_order, :notes)
      should allow_param(:purchase_order, :project_id)
      should allow_param(:purchase_order, :supplier_id)
      should_not allow_param(:user, :name)
      should allow('users/registrations', :edit)
      should allow('users/registrations', :update)
    end
  end
end