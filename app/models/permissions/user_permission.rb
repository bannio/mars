module Permissions
  class UserPermission < BasePermission
    def initialize(user)
      allow :home, [:index]
      allow :companies, [:index, :show]
      allow :addresses, [:index, :show]
      allow :contacts, [:index, :show]
      allow :projects, [:index, :show]
      allow :quotations, [:index, :show]
      allow :quotation_lines, [:index, :show]
      allow 'users/registrations', [:edit, :update]
      if user.has_role?('company')
        allow :companies, [:new, :create, :edit, :update, :destroy] 
        allow_param :company, [:name, :reference]
        allow :addresses, [:new, :create, :edit, :update, :destroy]
        allow_param :address, [:name, :body, :post_code, :company_id]
        allow :contacts, [:new, :create, :edit, :update, :destroy]
        allow_param :contact, [:email, :fax, :job_title, :mobile, :name, :notes, :telephone, :company_id, :address_id]
      end
      if user.has_role?('project')
        allow :projects, [:new, :create, :edit, :update, :destroy] 
        allow_param :project, [:name, :code, :company_id, :start_date, :due_date, :completion_date, :status, :value, :notes]
      end
      if user.has_role?('sales_quote')
        allow :quotations, [:new, :create, :edit, :update, :destroy, :import]
        allow :quotation_lines, [:new, :create, :edit, :update, :destroy]
        allow_param :quotation, [:code, :address_id, :delivery_address_id,
          :description, :customer_id, :contact_id, :issue_date, :name, :notes, :project_id, :status, :supplier_id,
          {quotation_lines_attributes: [:quotation_id, :description, :name, :quantity, :total, :unit_price]}]
        allow_param :quotation_line, [:quotation_id, :description, :name, :quantity, :total, :unit_price]
      end
    end
  end
end