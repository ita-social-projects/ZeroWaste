FactoryBot.define do
  factory :product_price do
    sequence(:category)   { |n| (n-1)%3 }
    sequence(:price)    { |n| n }
    association :product, title: "diaper", id: 1
  end
end
