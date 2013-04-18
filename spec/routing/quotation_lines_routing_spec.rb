require "spec_helper"

describe QuotationLinesController do
  describe "routing" do

    it "routes to #index" do
      get("quotations/1/quotation_lines").should route_to("quotation_lines#index",:quotation_id => '1')
    end

    it "routes to #new" do
      get("quotations/1/quotation_lines/new").should route_to("quotation_lines#new", :quotation_id => '1')
    end

    it "routes to #show" do
      get("quotations/1/quotation_lines/1").should route_to("quotation_lines#show", :quotation_id => '1', :id => "1")
    end

    it "routes to #edit" do
      get("quotations/1/quotation_lines/1/edit").should route_to("quotation_lines#edit",:quotation_id => '1', :id => "1")
    end

    it "routes to #create" do
      post("quotations/1/quotation_lines").should route_to("quotation_lines#create", :quotation_id => '1')
    end

    it "routes to #update" do
      put("quotations/1/quotation_lines/1").should route_to("quotation_lines#update",:quotation_id => '1', :id => "1")
    end

    it "routes to #destroy" do
      delete("quotations/1/quotation_lines/1").should route_to("quotation_lines#destroy",:quotation_id => '1', :id => "1")
    end

  end
end
