# frozen_string_literal: true

# == Schema Information
#
# Table name: product_types
#
#  id         :bigint           not null, primary key
#  title      :string
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_product_types_on_uuid  (uuid) UNIQUE
#
FactoryBot.define do
  factory :product_type do
    trait :hygiene do
      title { 'hygiene' }
    end
  end
end
