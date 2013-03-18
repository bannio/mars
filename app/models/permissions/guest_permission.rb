module Permissions
  class GuestPermission < BasePermission
    def initialize
      allow :home, [:index]
      #allow 'users/registrations', [:new, :create]
    end
  end
end