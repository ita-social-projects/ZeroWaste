# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { 'diaper' }
    association :product_type, title: "hygiene", id: 1
  end
end
