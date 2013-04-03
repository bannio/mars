require "spec_helper"

describe AddressesController do
  describe "routing" do

    it "routes to #index" do
      get("/addresses/index").should route_to("addresses#index")
    end

    it "routes to #new" do
      get("/companies/1/addresses/new").should route_to("addresses#new", company_id: "1")
    end

    it "routes to #show" do
      get("/companies/1/addresses/1").should route_to("addresses#show", :id => "1", company_id: "1")
    end

    it "routes to #edit" do
      get("/companies/1/addresses/1/edit").should route_to("addresses#edit", :id => "1", company_id: "1")
    end

    it "routes to #create" do
      post("/companies/1/addresses").should route_to("addresses#create", company_id: "1")
    end

    it "routes to #update" do
      put("/companies/1/addresses/1").should route_to("addresses#update", :id => "1", company_id: "1")
    end

    it "routes to #destroy" do
      delete("/companies/1/addresses/1").should route_to("addresses#destroy", :id => "1", company_id: "1")
    end

  end
end
