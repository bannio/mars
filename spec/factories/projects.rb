# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    code "MyString"
    name "MyString"
    company_id 1
    start_date "2013-04-11"
    end_date "2013-04-11"
    completion_date "2013-04-11"
    status "MyString"
    value 1
    notes "MyText"
  end
end
