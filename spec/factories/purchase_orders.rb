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
    delivery_address_id 1
    status "MyString"
    total "9.99"
    due_date 1.month.from_now
  end
end
