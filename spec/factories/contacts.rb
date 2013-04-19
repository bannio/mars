# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    name "MyString"
    company_id 1
    job_title "MyString"
    address nil
    telephone "MyString"
    mobile "MyString"
    fax "MyString"
    email "me@example.com"
    notes "MyText"
  end
end
