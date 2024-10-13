# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  name       :string
#  preferable :boolean          default(FALSE)
#  slug       :string
#  uuid       :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_calculators_on_name  (name) UNIQUE
#  index_calculators_on_slug  (slug) UNIQUE
#  index_calculators_on_uuid  (uuid) UNIQUE
#

class Calculator < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :sequentially_slugged

  has_paper_trail

  belongs_to :product

  has_many :fields, dependent: :destroy

  accepts_nested_attributes_for :fields, allow_destroy: true

  validates :name, presence: true
  validates :name,
            length: { in: 2..30 },
            uniqueness: true,
            format: { with: /\A[a-zA-Zа-яієїґ'А-ЯІЄЇҐ0-9\-\s]+\z/ },
            allow_blank: true

  scope :ordered_by_name, -> { order(:name) }
  scope :by_name_or_slug, lambda { |search|
                            where(
                              "name ILIKE ? OR slug ILIKE ?",
                              "%#{search&.strip}%",
                              "%#{search&.strip}%"
                            )
                          }

  def normalize_friendly_id(input)
    input.to_slug.transliterate(:ukrainian).normalize.to_s
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "preferable", "slug", "updated_at", "uuid"]
  end
end
