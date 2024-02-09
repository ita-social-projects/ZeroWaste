FactoryBot.define do
  factory :diapers_period do
    association :category
    period_start { 1 }
    period_end { 30 }
    price { 10 }
    usage_amount { 5 }

    trait :with_category do
      association :category, factory: :category, name: "budgetary"
    end

    trait :updated_usage_amount do
      usage_amount { 7 }
    end
  end
end
