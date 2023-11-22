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

  friendly_id :name, use: :slugged

  has_paper_trail

  has_many :fields, dependent: :destroy

  belongs_to :product

  accepts_nested_attributes_for :fields, allow_destroy: true

  validates :name, length: { minimum: 2 },
                   format: { with: /\A[a-zA-Zа-яієїґ'А-ЯІЄЇҐ0-9\s]+\z/, message: :name_format_validation },
                   uniqueness: true

  scope :ordered_by_name, -> { order(:name) }
  scope :by_name_or_slug, lambda { |search|
                            where(
                              "name ILIKE ? OR slug ILIKE ?",
                              "%#{search&.strip}%",
                              "%#{search&.strip}%"
                            )
                          }
end
