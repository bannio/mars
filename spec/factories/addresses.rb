# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    association :company
    name "MyString"
    body "MyText"
    post_code "MyString"
    factory :delivery_address do
      name "delivery place"
      association :company, factory: :client
    end
  end


end
