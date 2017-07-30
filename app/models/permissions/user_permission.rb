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
      allow :sales_orders, [:index, :show]
      allow :purchase_orders, [:index, :show]
      allow :sales_order_lines, [:index, :show]
      allow :purchase_order_lines, [:index, :show]
      allow 'users/registrations', [:edit, :update]
      allow :emails, [:new, :create, :index, :show, :download_attachment]
      allow_param :email, [:attachment, :body, :emailable_id, :emailable_type,
        :from, :subject, :to, cc: []]
      if user.has_role?('company')
        allow :companies, [:new, :create, :edit, :update, :destroy]
        allow_param :company, [:name, :reference]
        allow :addresses, [:new, :create, :edit, :update, :destroy]
        allow_param :address, [:name, :body, :post_code, :company_id]
        allow :contacts, [:new, :create, :edit, :update, :destroy]
        allow_param :contact, [:email, :fax, :job_title, :mobile, :name, :notes, :telephone, :company_id, :address_id]
      end
      if user.has_role?('project')
        allow :projects, [:new, :create, :edit, :update, :destroy, :close]
        allow_param :project, [:name, :code, :company_id, :start_date,
          :due_date, :completion_date, :status, :value, :notes]
      end
      if user.has_role?('sales_quote')
        allow :quotations, [:new, :create, :edit, :update, :destroy,
          :import, :issue, :reopen, :cancel, :list_emails, :list_events, :convert, :copy_line]
        allow :quotation_lines, [:new, :create, :edit, :update, :destroy, :sort]
        allow_param :quotation, [:code, :address_id, :delivery_address_id,
          :description, :customer_id, :contact_id, :issue_date, :name, :notes, :project_id, :supplier_id,
          {quotation_lines_attributes: [:quotation_id, :description, :name, :quantity, :total, :unit_price, :category, :position]}]
        allow_param :quotation_line, [:quotation_id, :description, :name, :quantity, :total, :unit_price, :category, :position]
      end
      if user.has_role?('sales_order')
        allow :sales_orders, [:new, :create, :edit, :update, :destroy,
                              :issue, :reopen, :cancel, :accept, :invoice, :paid, :list_emails, :list_events, :copy_line]
        allow :sales_order_lines, [:new, :create, :edit, :update, :destroy, :sort]
        allow_param :sales_order, [:code, :address_id, :delivery_address_id, :total,
          :description, :customer_id, :contact_id, :issue_date, :name, :notes, :project_id, :supplier_id, :status,
          {sales_order_lines_attributes: [:sales_order_id, :description, :name, :quantity, :total, :unit_price, :category, :position]}]
        allow_param :sales_order_line, [:sales_order_id, :description, :name, :quantity, :total, :unit_price, :category, :position]
      end
      if user.has_role?('purchase')
        allow :purchase_orders, [:setup, :new, :create, :edit, :update, :destroy, :show, :import,
                              :issue, :reopen, :cancel, :receipt, :paid, :select_order_lines, :create_order_lines,
                              :list_emails, :list_events, :search, :create_from_search, :copy_line]
        allow :purchase_order_lines, [:new, :create, :edit, :update, :destroy, :sort]
        allow_param :purchase_order, [:code, :address_id, :delivery_address_id, :total, :due_date,
          :description, :customer_id, :contact_id, :issue_date, :name, :notes, :project_id, :supplier_id, :client_id, :status,
          {purchase_order_lines_attributes: [:purchase_order_id, :description, :name, :quantity, :total, :unit_price, :category, :position, :discount]}]
        allow_param :purchase_order_line, [:purchase_order_id, :description, :name, :quantity, :total, :unit_price, :category, :position, :discount]
      end
    end
  end
end