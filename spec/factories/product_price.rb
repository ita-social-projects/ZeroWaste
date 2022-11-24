FactoryBot.define do
  factory :product_price do
    association :product, :diaper

    trait :budgetary do
      category { :budgetary }
      price { 4.99 }
    end

    trait :medium do
      category { :medium }
      price { 6.36 }
    end

    trait :premium do
      category { :premium }
      price { 8.21 }
    end
  end
end
