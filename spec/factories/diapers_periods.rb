FactoryBot.define do
  factory :diapers_period do
    category factory: [:category]
    period_start { 1 }
    period_end { 30 }
    price { 10 }
    usage_amount { 5 }
  end
end
