FactoryGirl.define do
  factory :sales_order do
  	sequence(:code) { |n| "SOtest00#{n}"}
    name "MySales Order"
    association :project
    association :customer
    association :supplier
    association :contact
    issue_date "2013-04-14"
    notes "MyNote"
    association :address
    delivery_address_id 1
    description "more text"
  end
end
