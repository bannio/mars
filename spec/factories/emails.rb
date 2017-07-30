# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    to "test@example.com"
    from "sender@example.com"
    subject "Subject of email"
    body "Email body text"
    cc ["","Copy@Recipients"]
    attachment "#{Rails.root}/spec/fixtures/SO001.pdf"
    association :emailable, factory: :quotation
    emailable_type "Quotation"
  end

  factory :quotation_email, class: "Email" do
    to "test@example.com"
    from "sender@example.com"
    subject "Subject of email"
    body "Email body text"
    attachment "#{Rails.root}/spec/fixtures/SO001.pdf"
    cc ["","Copy@Recipients"]
    association :emailable, factory: :quotation
    emailable_type "Quotation"
  end
end