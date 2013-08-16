require 'spec_helper'

describe EmailsController do
	def valid_attributes
		{
			from: 		'from@example.com',
			to:     	'to@example.com', 
			subject: 	'My Email',
			body:    	'Email text here',
			attachment: File.join(Rails.root, 'spec/fixtures/SQ001.pdf'),
      cc:        '',
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
      # @company = FactoryGirl.create(:company)
      # params = {}
      # params[:company] = @company
	end

	describe 'GET index' do
		it "assigns all emails as @emails" do
			email = Email.create! valid_attributes
			get :index, {}, valid_session
			assigns(:emails).should eq([email])
		end
	end

  describe 'POST create' do

    it "copes with multiple cc emails" do
      email = valid_attributes.merge(cc: ["","one@example.com","two@example.com"])

      post :create, {email: email}, valid_session
      @email = Email.last.reload
      expect(@email.cc).to eq(["","one@example.com","two@example.com"])
    end

    it "copes with a single cc email address" do
      email = valid_attributes.merge(cc: ["","one@example.com"])
      post :create, {email: email}, valid_session
      @email = Email.last.reload
      expect(@email.cc).to eq(["","one@example.com"])
    end

    it "copes with an empty cc array" do
      email = valid_attributes.merge(cc: [""])
      post :create, {email: email}, valid_session
      @email = Email.last.reload
      expect(@email.cc).to eq([""])
    end
  end
end
