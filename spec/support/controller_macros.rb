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

  # def sign_in_user(user = double('user'))
  #   if user.nil?
  #     allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
  #     allow(controller).to receive(:current_user).and_return(nil)
  #   else
  #     allow(request.env['warden']).to receive(:authenticate!).and_return(user)
  #     allow(controller).to receive(:current_user).and_return(user)
  #   end
  # end

end
