# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    code "ProjCode"
    name "ProjName"
    company_id 1
    start_date "2013-04-11"
    end_date "2013-04-12"
    completion_date "2013-04-13"
    status "MyString"
    value 1
    notes "MyText"
  end
end
