# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sales_link do
    association :purchase_order_line
    association :sales_order_line
  end
end
