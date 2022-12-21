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
#  index_prices_on_category_id  (category_id)
#  index_prices_on_priceable    (priceable_type,priceable_id)
#
FactoryBot.define do
  factory :price do
    trait :budgetary_price do
      association :category, :budgetary
      sum { 42 }
    end

    trait :medium_price do
      association :category, :medium
      sum { 42 }
    end
  end
end
