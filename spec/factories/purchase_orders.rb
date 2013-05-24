# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase_order do
    name "MyString"
    project nil
    customer nil
    supplier nil
    contact nil
    issue_date Date.today
    notes "MyText"
    address nil
    code "MyString"
    description "MyText"
    delivery_address_id 1
    status "MyString"
    total "9.99"
    due_date 1.month.from_now
  end
end
