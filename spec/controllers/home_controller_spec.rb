require 'spec_helper'

describe HomeController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      # response.should be_success
      expect(response).to be_success
    end
  end

end
