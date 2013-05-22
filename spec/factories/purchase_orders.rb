# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_order do
    name "MyString"
    project nil
    customer nil
    supplier nil
    contact nil
    issue_date "2013-05-20"
    notes "MyText"
    address nil
    code "MyString"
    description "MyText"
    delivery_address_id 1
    status "MyString"
    total "9.99"
  end
end
