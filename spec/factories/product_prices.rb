FactoryBot.define do
  factory :product_price do
    price { 11.1 }
    category { 1 }
    product
  end
end
