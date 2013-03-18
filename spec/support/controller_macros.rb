module ControllerMacros
  # def login_admin
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:user]
  #     sign_in FactoryGirl.create(:user, roles_mask: 1) 
  #   end
  # end
  # 
  # def login_company_user
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:user]
  #     sign_in = FactoryGirl.create(:user, roles_mask: 2)
  #   end
  # end
  # 
  # def login_guest_user
  #   # no login as guest
  #   before(:each) do
  #     @request.env["devise.mapping"] = Devise.mappings[:user]
  #     user = FactoryGirl.create(:user)
  #   end
  # end
end

