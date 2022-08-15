# frozen_string_literal: true

class FeatureFlag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def add_new_feature
    FeatureFlag.create(name: self.name, enabled: false)
  end
  
  def feature_added?
    FeatureFlag.exists?(:name=>self.name)
  end

  def activate
    feature_flag = self.feature_added? ? self : self.add_new_feature
    feature_flag.update(enabled: true)
    feature_flag
  end

  def deactivate
    feature_flag = self.feature_added? ? self : self.add_new_feature
    feature_flag.update(enabled: false)
    feature_flag
  end

  def active?
    self.feature_added? ? self.enabled : false
  end

end