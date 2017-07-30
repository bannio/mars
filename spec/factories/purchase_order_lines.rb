# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_order_line do
    association :purchase_order
    name "MyString"
    description "MyText"
    quantity 1
    unit_price "9.99"
    total "9.99"
    category ""
    position 1
  end
end