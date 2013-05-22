# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_order_line do
    purchase_order nil
    name "MyString"
    description "MyText"
    quantity 1
    unit_price "9.99"
    total "9.99"
  end
end
