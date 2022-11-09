# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  uuid       :uuid             not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  preferable :boolean          default(FALSE)
#
class Calculator < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :fields
  has_paper_trail

  accepts_nested_attributes_for :fields, allow_destroy: true

  validates :name, format: { with: /\A[a-zA-Z0-9\s]+\z/,
                             message: 'Only letters and numbers allowed' }
  validates :name, length: { minimum: 2 }
  validates :name, uniqueness: true

  scope :by_name_or_slug, lambda { |search|
                            where('name ILIKE ? OR slug ILIKE ?',
                                  "%#{search&.strip}%",
                                  "%#{search&.strip}%")
                          }
end
