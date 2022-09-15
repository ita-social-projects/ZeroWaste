FactoryBot.define do
  factory :product_price do
    association :product, title: "diaper", id: 1
    trait :LOW do
      category { :LOW }
      price { 4.99 }
    end
    trait :MEDIUM do
      category { :MEDIUM }
      price { 6.36 }
    end
    trait :HIGH do
      category { :HIGH }
      price { 8.21 }
    end
  end
end
