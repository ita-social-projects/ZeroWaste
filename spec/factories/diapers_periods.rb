FactoryBot.define do
  factory :diapers_period do
    association :category, factory: :category
    period_start { 1 }
    period_end { 30 }
    price { 10 }
    usage_amount { 5 }

    trait :with_category do
      association :category, factory: :category, name: "budgetary"
    end
  end
end
