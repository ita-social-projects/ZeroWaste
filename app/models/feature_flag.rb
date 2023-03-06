# frozen_string_literal: true

# == Schema Information
#
# Table name: feature_flags
#
#  id         :bigint           not null, primary key
#  enabled    :boolean          default(FALSE), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_feature_flags_on_name  (name) UNIQUE
#
class FeatureFlag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def self.has_feature?(feature)
    find_by(name: feature.to_s, enabled: true).present?
  end

  def self.enable_feature!(feature)
    feature_flag = find_or_initialize_by(name: feature.to_s)
    feature_flag.enabled = true
    feature_flag.save!
  end

  def self.disable_feature!(feature)
    feature_flag = find_or_initialize_by(name: feature.to_s)
    feature_flag.enabled = false
    feature_flag.save!
  end
end
