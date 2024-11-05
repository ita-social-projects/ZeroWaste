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
                      content_type: [:png, :ico],
                      size: { less_than_or_equal_to: 1.kilobyte },
                      dimension: { width: { min: 16, max: 180 },
                                   height: { min: 16, max: 180 }},
                      aspect_ratio: :square

  after_initialize :set_default_favicon

  singleton_class.alias_method :current, :instance

  def self.restore_defaults!
    default_attributes = {
      title: "ZeroWaste",
      favicon: {
        io: File.open("app/assets/images/icons/favicon-48x48.png"),
        filename: "favicon-48x48.png",
        content_type: "image/png"
      }
    }

    SiteSetting.current.update(default_attributes)
  end

  private

  def set_default_favicon
    if new_record? && !favicon.attached?
      favicon.attach(
        io: File.open("app/assets/images/icons/favicon-48x48.png"),
        filename: "favicon-48x48.png",
        content_type: "image/png"
      )
    end
  end
end
