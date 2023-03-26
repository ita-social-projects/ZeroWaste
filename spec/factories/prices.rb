FactoryBot.define do
  factory :price do
    trait :budgetary_price do
      sum { "40.2" }
    end
  end
end
