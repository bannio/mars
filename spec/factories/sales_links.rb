# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sales_link do
    purchase_order_line nil
    sales_order_line nil
  end
end
