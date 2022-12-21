class SiteSetting < ApplicationRecord
  has_one_attached :favicon, dependent: :destroy

  validates :title, presence: true

  before_save :disable_all_except_current, if: ->() { enabled }
  after_save :enable_last, if: ->() { !enabled && SiteSetting.get_active.nil? }

  before_destroy :restrict_enabled_destroy, if: ->() { enabled }


  def disable_all_except_current
    SiteSetting.where.not(id: id).update_all(enabled: false)
  end

  def enable_last
    SiteSetting.last.update(enabled: true)
  end

  def restrict_enabled_destroy
    raise ActiveRecord::RecordNotDestroyed, 'Enabled record cannot be destroyed'
  end

  def favicon_with_proper_size
    favicon.variant(resize_to_limit: [100, 100]).processed
  end

  def self.get_active
    find_by(enabled: true)
  end

  def self.get_active_favicon
    get_active.favicon
  end

  def self.get_active_title
    get_active.title
  end
end
