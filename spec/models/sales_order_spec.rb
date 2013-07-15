require 'spec_helper'

describe SalesOrder do
  describe "searching" do
  	before :each do |variable|
  		@order1 = FactoryGirl.create(:sales_order, code: 'SO01', name: 'Az')
  		@order2 = FactoryGirl.create(:sales_order, code: 'SO02', name: 'Bz')
  		@order3 = FactoryGirl.create(:sales_order, code: 'SO03', name: 'az')
  		@order4 = FactoryGirl.create(:sales_order, code: 'SO04', name: 'Xz')
  	end
  	it "returns matching relations" do
  		expect(SalesOrder.search('Bz')).to eq([@order2])
  	end

  	it "is not case sensitive" do
  		expect(SalesOrder.search('A')).to eq([@order1, @order3])
  	end

  	it "copes with blank" do
  		expect(SalesOrder.search(nil)).to eq([@order1, @order2, @order3, @order4])
  	end

  end
end
