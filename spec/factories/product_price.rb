FactoryBot.define do
  factory :product_price do
    category { |n| n }
    price { 0.0 }
    association :product, title: "diaper", id: 1
  end
end
