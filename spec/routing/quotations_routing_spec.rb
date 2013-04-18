require "spec_helper"

describe QuotationsController do
  describe "routing" do

    it "routes to #index" do
      get("/quotations").should route_to("quotations#index")
    end

    it "routes to #new" do
      get("/quotations/new").should route_to("quotations#new")
    end

    it "routes to #show" do
      get("/quotations/1").should route_to("quotations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/quotations/1/edit").should route_to("quotations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/quotations").should route_to("quotations#create")
    end

    it "routes to #update" do
      put("/quotations/1").should route_to("quotations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/quotations/1").should route_to("quotations#destroy", :id => "1")
    end

  end
end
