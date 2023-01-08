class SiteSetting < ApplicationRecord
  has_one_attached :favicon, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :favicon, attached: true,
                      content_type: [:png, :jpg, :jpeg, :ico],
                      size: { less_than: 500.kilobytes,
                              message: I18n.t("account.site_settings.validations.size") }

  before_save :ensure_one_active!

  private

  def ensure_one_active!
    return unless active_changed?(to: true)

    SiteSetting.where(active: true).where.not(id: id)
               .find_each { |s| s.update(active: false) }
  end
end
