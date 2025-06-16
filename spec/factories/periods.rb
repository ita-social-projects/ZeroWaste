FactoryBot.define do
  factory :period do
    period_start { 1 }
    period_end { 1 }
    usage_amount { 1 }
    category { nil }
    price { "9.99" }
  end
end
