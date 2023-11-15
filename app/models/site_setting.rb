# == Schema Information
#
# Table name: site_settings
#
#  id         :bigint           not null, primary key
#  title      :string           default("ZeroWaste"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class SiteSetting < ApplicationRecord
  acts_as_singleton

  has_one_attached :favicon, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 3, maximum: 30 }, if: -> { title.present? }
  validates :favicon, attached: true,
                      content_type: [:png, :jpg, :jpeg, :ico],
                      size: { less_than: 500.kilobytes }

  after_initialize :set_default_faviconпше

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
