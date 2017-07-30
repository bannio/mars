# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quotation do
    name "MyString"
    association :project
    association :customer
    association :supplier
    association :contact
    issue_date "2013-04-14"
    notes "MyText"
    association :address
    association :delivery_address
    description "more text"
    status "open"
    total 0.0
  end
end
