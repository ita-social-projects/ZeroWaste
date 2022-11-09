# frozen_string_literal: true

# == Schema Information
#
# Table name: feature_flags
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  enabled    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
