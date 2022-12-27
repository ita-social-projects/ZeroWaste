class SiteSetting < ApplicationRecord
  @@__active = nil

  default_scope { order(created_at: :desc) }

  has_one_attached :favicon, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :favicon, attached: true,
                      content_type: [:png, :jpg, :jpeg, :ico],
                      size: { less_than: 500.kilobytes,
                              message: I18n.t("account.site_settings.validations.size") }

  before_save :ensure_one_active!
  before_destroy :restrict_destruction_of_active

  def self.active
    @@__active = find_by(enabled: true) if @@__active.nil?

    @@__active
  end

  def self.active=(site_setting)
    @@__active = site_setting if site_setting.is_a?(self) && site_setting.enabled
  end

  private

  def ensure_one_active!
    return unless enabled_changed?(to: true)

    SiteSetting.where(enabled: true).where.not(id: id)
               .find_each { |s| s.update(enabled: false) }

    SiteSetting.active = self
  end

  def restrict_destruction_of_active
    raise ActiveRecord::RecordNotDestroyed if enabled
  end
end
