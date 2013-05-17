# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    sequence(:name) { |n| "contact#{n}"}
    company_id 1
    job_title "MyString"
    address nil
    telephone "MyString"
    mobile "MyString"
    fax "MyString"
    sequence(:email) { |n| "contact#{n}@example.com"}
    notes "MyText"
  end
end
