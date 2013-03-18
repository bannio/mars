module Permissions
  class UserPermission < BasePermission
    def initialize(user)
      allow :home, [:index]
      allow 'users/registrations', [:edit, :update]
      if user.has_role?('company')
        allow :companies, [:index, :show, :new, :create, :edit, :update, :destroy] 
        allow_param :company, :name
      end
    end
  end
end