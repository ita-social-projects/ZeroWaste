FactoryBot.define do
    factory :product_price do
      price { 1111 }
      category { "MEDIUM" }
      product
    end
  end