# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sales_order_line do
    association :sales_order
    name "MyString"
    description "MyText"
    quantity 1
    unit_price 10
    total ""
    position 1
    category ""
  end
end
