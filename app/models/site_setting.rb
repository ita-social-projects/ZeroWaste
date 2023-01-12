class SiteSetting < ApplicationRecord
  acts_as_singleton

  has_one_attached :favicon, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }
  validates :favicon, attached: true,
                      content_type: [:png, :jpg, :jpeg, :ico],
                      size: { less_than: 500.kilobytes,
                              message: I18n.t("account.site_settings.validations.size") }
end
