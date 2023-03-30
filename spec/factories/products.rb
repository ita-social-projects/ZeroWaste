# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  title           :string
#  uuid            :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_type_id :bigint
#
# Indexes
#
#  index_products_on_product_type_id  (product_type_id)
#  index_products_on_uuid             (uuid) UNIQUE
#
FactoryBot.define do
  factory :product do

    # after(:create) do |product|
    #   product.prices << FactoryBot.create(:price, priceable: product)
    # end

    trait :diaper do
      title { "diaper" }
    end

    trait :napkin do
      title { "napkin" }
    end

    trait :huggie do
      title { "huggie" }
      prices_attributes do
        {
          "0":
            {id: id, sum: sum}
        }
      end
    end

    trait :no_title do
      title { '' }
      prices_attributes do
        {
          "0":
            {id: id, sum: 10.1}
        }
      end
    end
  end
end
