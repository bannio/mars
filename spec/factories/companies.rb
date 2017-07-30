# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name "MyCompany"

    factory :customer do
    	name "MyCustomer"
	  end

	  factory :supplier do
	  	name "MySupplier"
	  end

	  factory :client do
	  	name "MyClient"
    end
  end

  factory :company_with_project, class: "Company" do
    after(:create) do |company|
      create(:project, company: company)
    end
    name "Company with project"
  end

  factory :company_with_po, class: "Company" do
    after(:create) do |company|
      create(:purchase_order, supplier: company)
    end
    name "Company with PO"
  end
end