FactoryBot.define do
  factory :price do
    association :priceable, factory: [:product, :diaper]

    trait :budgetary_price do
      sum { 40.2 }
    end

    trait :invalid_price do
      sum { "" }
    end
  end
end
