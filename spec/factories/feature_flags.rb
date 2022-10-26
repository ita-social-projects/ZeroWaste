# frozen_string_literal: true

FactoryBot.define do
  factory :feature_flag do
    name { 'FeatureFlag' }
    enabled { false }
    trait :show_admin_menu do
      name { 'show_admin_menu' }
      enabled { true }
    end
    trait :hide_admin_menu do
      name { 'show_admin_menu' }
      enabled { false }
    end
  end
end
