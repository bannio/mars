# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    company_id 1
    name "MyString"
    body "MyText"
    post_code "MyString"
  end
end
