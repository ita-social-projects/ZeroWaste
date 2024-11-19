# == Schema Information
#
# Table name: prices
#
#  id             :bigint           not null, primary key
#  priceable_type :string
#  sum            :decimal(8, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :integer
#  priceable_id   :bigint
#
# Indexes
#
#  idx_on_category_id_priceable_id_priceable_type_1fa9ce7f24  (category_id,priceable_id,priceable_type) UNIQUE
#  index_prices_on_category_id                                (category_id)
#  index_prices_on_priceable                                  (priceable_type,priceable_id)
#

FactoryBot.define do
  factory :price do
    priceable factory: [:product, :diaper]

    trait :budgetary_price do
      category factory: [:category, :budgetary]
      sum { Faker::Number.between(from: 20, to: 42) }
    end

    trait :medium_price do
      category factory: [:category, :medium]
      sum { Faker::Number.between(from: 42, to: 71) }
    end

    trait :invalid_price do
      sum { "" }
    end
  end
end
