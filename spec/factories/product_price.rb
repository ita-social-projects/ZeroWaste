FactoryBot.define do
    factory :product_price do
      price { 1111 }
      category { "MEDIUM" }
      association :product, title: "diaper", id: 1
    end
  end
