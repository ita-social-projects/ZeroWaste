# == Schema Information
#
# Table name: site_settings
#
#  id         :integer          not null, primary key
#  title      :string           default("ZeroWaste")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SiteSetting < ApplicationRecord
  acts_as_singleton

  has_one_attached :favicon, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :favicon, attached: true,
                      content_type: [:png, :jpg, :jpeg, :ico],
                      size: { less_than: 500.kilobytes,
                              message: I18n.t("account.site_settings.validations.size") }

  after_initialize :set_default_favicon

  singleton_class.alias_method :current, :instance

  private

  def set_default_favicon
    if new_record? && !favicon.attached?
      favicon.attach(
        io: File.open("app/assets/images/logo_zerowaste.png"),
        filename: "logo_zerowaste.png",
        content_type: "image/png"
      )
    end
  end
end
