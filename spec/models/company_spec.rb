require 'spec_helper'

describe Company do

  before(:each) do
    @attr = {
      name: "My company",
      reference: 'ABC123'
    }
  end

  it "should require a name" do
    company = Company.new(@attr.merge(name: ''))
    expect(company).to_not be_valid
  end

  describe '#destroy' do

    it "checks purchase orders exist before destroy" do
      company = create(:company)
      purchase_order = create(:purchase_order, supplier_id: company.id)
      expect{company.destroy}.to_not change(Company, :count)
    end

    it "checks sales orders exist before destroy" do
      company = create(:company)
      sales_order = create(:sales_order, customer_id: company.id)
      expect{company.destroy}.to_not change(Company, :count)
    end
  end
end
