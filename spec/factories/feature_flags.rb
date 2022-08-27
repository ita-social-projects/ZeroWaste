# frozen_string_literal: true

FactoryBot.define do
  factory :feature_flag do
    name { 'FeatureFlag' }
    enabled { false }
  end
end
