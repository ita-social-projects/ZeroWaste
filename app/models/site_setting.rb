class SiteSetting < ApplicationRecord
  default_scope { order("created_at DESC") }

  has_one_attached :favicon, dependent: :destroy

  validates :title, presence: true
  validates :favicon, presence: true

  before_save :disable_all_except_current, if: -> { enabled }
  before_destroy :restrict_enabled_destroy, if: -> { enabled }

  def disable_all_except_current
    SiteSetting.where.not(id: id).find_each { |s| s.update(enabled: false) }
  end

  def restrict_enabled_destroy
    raise ActiveRecord::RecordNotDestroyed, "Enabled record cannot be destroyed"
  end

  def favicon_with_proper_size
    favicon.variant(resize_to_limit: [100, 100]).processed
  end

  def self.get_enabled
    find_by(enabled: true)
  end

  def enable
    update(enabled: true)
  end
end
