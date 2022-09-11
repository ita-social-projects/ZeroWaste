# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { 'diaper' }
    product_type { association :product_type }
  end
end
