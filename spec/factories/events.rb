# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    state "open"
    user
    association :eventable, factory: :quotation
    eventable_type "Quotation"
    factory :quotation_event do
      association :eventable, factory: :quotation
      eventable_type "Quotation"
    end
    factory :purchase_order_event do
      association :eventable, factory: :purchase_order
      eventable_type "PurchaseOrder"
    end
      factory :sales_order_event do
      association :eventable, factory: :sales_order
      eventable_type "SalesOrder"
    end
    trait :in_issued_state do
      state "issued"
    end
    trait :in_open_state do
      state "open"
    end
    trait :in_cancelled_state do
      state "cancelled"
    end
  end
end
