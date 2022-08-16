# frozen_string_literal: true

class FeatureFlag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def create
    FeatureFlag.create(name: name, enabled: false)
  end

  def feature_exist?
    FeatureFlag.exists?(name: name)
  end

  def activate
    feature_flag = feature_exist? ? self : create
    feature_flag.update(enabled: true)
    feature_flag
  end

  def deactivate
    feature_flag = feature_exist? ? self : create
    feature_flag.update(enabled: false)
    feature_flag
  end

  def active?
    feature_exist? ? enabled : false
  end
end
