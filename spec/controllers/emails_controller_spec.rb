require 'spec_helper'

describe EmailsController do
	def valid_attributes
		{
			from: 		'from@example.com',
			to:     	'to@example.com', 
			subject: 	'My Email',
			body:    	'Email text here',
			attachment: 'SQ001.pdf',
			emailable_type: 'Quotation',
			emailable_id: 1
		}
	end

	def valid_session
	    {"warden.user.user.key" => session["warden.user.user.key"]}.merge(return_to: addresses_index_path)
	end

  before do
      user = double('user')
      request.env['warden'].stub :authenticate! => user
      controller.stub :current_user => user
      user.stub(:has_role?) do |role|
        if role == 'sales_quote'
          true
        end
      end
      @quotation = FactoryGirl.create(:quotation)
      @company = FactoryGirl.create(:company)
      params = {}
      params[:company] = @company
	end

	describe 'GET index' do
		it "assigns all emails as @emails" do
			email = Email.create! valid_attributes
			get :index, {}, valid_session
			assigns(:emails).should eq([email])
		end
	end
end
