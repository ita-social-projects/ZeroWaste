# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  uuid            :uuid             not null
#  title           :string
#  product_type_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :product do
    title { 'diaper' }
    association :product_type, title: "hygiene", id: 1
  end
end
