# frozen_string_literal: true

# == Schema Information
#
# Table name: product_types
#
#  id         :bigint           not null, primary key
#  uuid       :uuid             not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :product_type do
    title { 'hygiene' }
  end
end
