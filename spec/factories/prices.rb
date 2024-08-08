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
#  index_prices_on_category_id                                      (category_id)
#  index_prices_on_category_id_and_priceable_id_and_priceable_type  (category_id,priceable_id,priceable_type) UNIQUE
#  index_prices_on_priceable                                        (priceable_type,priceable_id)
#
FactoryBot.define do
  factory :price do
    association :priceable, factory: [:product, :diaper]

    trait :budgetary_price do
      sum { 7 }
    end

    trait :medium_price do
      sum { 15 }
    end

    trait :invalid_price do
      sum { "" }
    end
  end
end
