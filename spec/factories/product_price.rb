# frozen_string_literal: true

FactoryBot.define do
  factory :product_price do
    association :product, title: "diaper", id: 1
    category { 'MEDIUM' }
    price { 636 }

    trait :BUDGETARY do
      category { 'BUDGETARY' }
      price { 499 }
    end
    trait :MEDIUM do
      category { 'MEDIUM' }
      price { 636 }
    end
    trait :PREMIUM do
      category { 'PREMIUM' }
      price { 821 }
    end
  end
end