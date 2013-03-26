module Permissions
  class UserPermission < BasePermission
    def initialize(user)
      allow :home, [:index]
      allow 'users/registrations', [:edit, :update]
      if user.has_role?('company')
        allow :companies, [:index, :show, :new, :create, :edit, :update, :destroy] 
        allow_param :company, [:name, :reference]
        allow :addresses, [:index, :show, :new, :create, :edit, :update, :destroy]
        allow_param :address, [:name, :body, :post_code, :company_id]
      end
    end
  end
end