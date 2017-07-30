# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_order do
    name "MyString"
    association :project
    association :customer
    association :supplier
    association :client
    association :contact
    issue_date Date.today
    notes "MyText"
    association :address
    code "MyString"
    description "MyText"
    association :delivery_address
    status "MyString"
    total "9.99"
    due_date 1.month.from_now
    trait :no_delivery_address do
        delivery_address nil
    end
  end
end
