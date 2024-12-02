# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  en_name    :string           default(""), not null
#  slug       :string
#  uk_name    :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_calculators_on_slug  (slug) UNIQUE
#

class Calculator < ApplicationRecord
  include Translatable
  extend FriendlyId

  friendly_id :en_name, use: :sequentially_slugged

  translates :name

  has_many :fields, dependent: :destroy
  has_many :formulas, dependent: :destroy

  accepts_nested_attributes_for :fields, allow_destroy: true
  accepts_nested_attributes_for :formulas, allow_destroy: true

  scope :ordered_by_name, -> { order(:en_name) }

  validates :en_name, :uk_name, presence: true
  validates :en_name, :uk_name, length: { minimum: 3, maximum: 50 }
  validates :slug, presence: true, uniqueness: true
  validates :english_additional_notes,
            length: {
              maximum: 500,
              tokenizer: ->(string) { ActionController::Base.helpers.strip_tags(string).chars }
            }

  validates :ukranian_additional_notes,
            length: {
              maximum: 500,
              tokenizer: ->(string) { ActionController::Base.helpers.strip_tags(string).chars }
            }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "preferable", "slug", "updated_at", "uuid"]
  end
end
