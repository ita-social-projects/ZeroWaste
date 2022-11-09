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
    title { 'diaper' }
    association :product_type, title: "hygiene", id: 1
  end
end
