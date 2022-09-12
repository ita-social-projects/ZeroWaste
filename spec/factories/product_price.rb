FactoryBot.define do
    factory :product_price do
      price { 1111 }
      category { 1 }
      product
    end
  end