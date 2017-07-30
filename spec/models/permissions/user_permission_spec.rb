require "spec_helper"

describe Permissions::UserPermission do
  describe "with no roles assigned" do
    let(:user) { create(:user) }
    subject { Permissions.permission_for(user) }

    it "allows" do
      should allow_action(:home, :index)
      # expect(allow_action(:home, :index)).to be
      should allow_action(:companies, :index)
      should allow_action(:contacts, :index)
      should allow_action(:projects, :index)
      should allow_action(:addresses, :index)
      should allow_action(:quotations, :index)
      should allow_action(:sales_orders, :index)
      should_not allow_action(:companies, :edit)
      should_not allow_action(:addresses, :edit)
      should_not allow_action(:contacts, :edit)
      should_not allow_action(:projects, :edit)
      should allow_action('users/registrations', :edit)
      should allow_action('users/registrations', :update)
    end
  end
  describe "with just company role" do
    let(:user) { create(:user, roles_mask: 2) }
    subject { Permissions.permission_for(user) }

    it "allow" do
      should allow_action(:home, :index)
      should allow_action(:companies, :index)
      should allow_action(:companies, :show)
      should allow_action(:companies, :new)
      should allow_action(:companies, :create)
      should allow_action(:companies, :edit)
      should allow_action(:companies, :update)
      should allow_action(:companies, :destroy)
      should_not allow_action(:users, :index)
      should allow_param(:company, :name)
      should_not allow_param(:user, :name)
      should allow_action('users/registrations', :edit)
      should allow_action('users/registrations', :update)
    end
  end
  describe "with just project role" do
    let(:user) { create(:user, roles_mask: 4) }
    subject { Permissions.permission_for(user) }

    it "allows" do
      should allow_action(:home, :index)
      should allow_action(:projects, :index)
      should allow_action(:projects, :show)
      should allow_action(:projects, :new)
      should allow_action(:projects, :create)
      should allow_action(:projects, :edit)
      should allow_action(:projects, :update)
      should allow_action(:projects, :destroy)
      should_not allow_action(:users, :index)
      should allow_param(:project, :name)
      should_not allow_param(:user, :name)
      should allow_action('users/registrations', :edit)
      should allow_action('users/registrations', :update)
    end
  end
  describe "with just sales_quote role" do
    let(:user) { create(:user, roles_mask: 8) }
    subject { Permissions.permission_for(user) }

    it "allows" do
      should allow_action(:home, :index)
      should allow_action(:quotations, :index)
      should allow_action(:quotations, :show)
      should allow_action(:quotations, :new)
      should allow_action(:quotations, :create)
      should allow_action(:quotations, :edit)
      should allow_action(:quotations, :update)
      should allow_action(:quotations, :destroy)
      should allow_action(:quotation_lines, :index)
      should allow_action(:quotation_lines, :show)
      should allow_action(:quotation_lines, :new)
      should allow_action(:quotation_lines, :create)
      should allow_action(:quotation_lines, :edit)
      should allow_action(:quotation_lines, :update)
      should allow_action(:quotation_lines, :destroy)
      should allow_action(:quotations, :issue)
      should allow_action(:quotations, :import)
      should allow_action(:quotations, :reopen)
      should_not allow_action(:users, :index)
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
      should allow_action('users/registrations', :edit)
      should allow_action('users/registrations', :update)
    end
  end
  describe "with just sales_order role" do
    let(:user) { create(:user, roles_mask: 16) }
    subject { Permissions.permission_for(user) }

    it "allows" do
      should allow_action(:home, :index)
      should allow_action(:quotations, :index)
      should allow_action(:quotations, :show)
      should_not allow_action(:quotations, :new)
      should_not allow_action(:purchase_orders, :new)
      should_not allow_action(:companies, :new)
      should allow_action(:sales_orders, :create)
      should allow_action(:sales_orders, :edit)
      should allow_action(:sales_orders, :update)
      should allow_action(:sales_orders, :destroy)
      should allow_action(:sales_order_lines, :new)
      should allow_action(:sales_order_lines, :create)
      should allow_action(:sales_order_lines, :edit)
      should allow_action(:sales_order_lines, :update)
      should allow_action(:sales_order_lines, :destroy)
      should allow_action(:sales_orders, :issue)
      should allow_action(:sales_orders, :reopen)
      should_not allow_action(:users, :index)
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
      should allow_action('users/registrations', :edit)
      should allow_action('users/registrations', :update)
    end
  end
  describe "with just purchase role" do
    let(:user) { create(:user, roles_mask: 32) }
    subject { Permissions.permission_for(user) }

    it "allows" do
      should allow_action(:home, :index)
      should allow_action(:quotations, :index)
      should allow_action(:quotations, :show)
      should_not allow_action(:quotations, :new)
      should_not allow_action(:sales_orders, :new)
      should_not allow_action(:companies, :new)
      should allow_action(:purchase_orders, :create)
      should allow_action(:purchase_orders, :edit)
      should allow_action(:purchase_orders, :update)
      should allow_action(:purchase_orders, :destroy)
      should allow_action(:purchase_order_lines, :new)
      should allow_action(:purchase_order_lines, :create)
      should allow_action(:purchase_order_lines, :edit)
      should allow_action(:purchase_order_lines, :update)
      should allow_action(:purchase_order_lines, :destroy)
      should allow_action(:purchase_orders, :issue)
      should allow_action(:purchase_orders, :reopen)
      should_not allow_action(:users, :index)
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
      should allow_action('users/registrations', :edit)
      should allow_action('users/registrations', :update)
    end
  end
end
