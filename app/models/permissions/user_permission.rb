module Permissions
  class UserPermission < BasePermission
    def initialize(user)
      allow :home, [:index]
      allow :companies, [:index, :show]
      allow :addresses, [:index, :show]
      allow :contacts, [:index, :show]
      allow 'users/registrations', [:edit, :update]
      if user.has_role?('company')
        allow :companies, [:new, :create, :edit, :update, :destroy] 
        allow_param :company, [:name, :reference]
        allow :addresses, [:new, :create, :edit, :update, :destroy]
        allow_param :address, [:name, :body, :post_code, :company_id]
        allow :contacts, [:new, :create, :edit, :update, :destroy]
        allow_param :contact, [:email, :fax, :job_title, :mobile, :name, :notes, :telephone, :company_id, :address_id]
      end
    end
  end
end