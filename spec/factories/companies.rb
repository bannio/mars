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
end
