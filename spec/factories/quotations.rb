# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quotation do
    name "MyString"
    project_id 1
    customer_id 1
    supplier_id 1
    contact_id 1
    issue_date "2013-04-14"
    status "MyString"
    notes "MyText"
    address_id 1
    delivery_address_id 1
    description "more text"
  end
end
