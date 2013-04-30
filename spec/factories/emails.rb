# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    to "MyString"
    from "MyString"
    subject "MyString"
    body "MyText"
    attachment "MyString"
    emailable_id 1
    emailable_type "MyString"
  end
end
