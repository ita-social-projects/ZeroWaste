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

  def create
    FeatureFlag.create!(name: name, enabled: false)
  end

  def feature_exist?
    FeatureFlag.exists?(name: name)
  end

  def activate
    (feature_exist? ? self : create).tap { |f| f.update(enabled: true) }
  end

  def deactivate
    (feature_exist? ? self : create).tap { |f| f.update(enabled: false) }
  end

  def active?
    feature_exist? ? enabled : false
  end

  def self.get(name)
    FeatureFlag.find_by(name: name) || FeatureFlag.new(name: name)
  end
end
