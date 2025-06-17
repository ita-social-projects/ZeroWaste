FactoryBot.define do
  factory :period do
    period_start { 1 }
    period_end { 2 }
    usage_amount { 1 }
    association :category
    price { "9.99" }
  end
end
