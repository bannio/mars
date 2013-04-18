# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quotation_line do
    name "MyString"
    description "MyText"
    quantity 1
    unit_price "9.99"
    total "9.99"
  end
end
