# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  color      :string           default("#000000")
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

  ALLOWED_LOGO_IMAGE_TYPES = ["image/jpeg", "image/png", "image/jpg"]

  friendly_id :en_name, use: :sequentially_slugged

  attribute :logo_placeholder, :string, default: "https://via.placeholder.com/428x307?text=Logo"
  translates :name, :notes

  has_one_attached :logo_picture
  has_many :fields, dependent: :destroy
  has_many :formulas, -> { ordered_by_priority }, dependent: :destroy, inverse_of: :calculator

  amoeba do
    enable
  end

  validates_with RelationValidator

  accepts_nested_attributes_for :fields, allow_destroy: true
  accepts_nested_attributes_for :formulas, allow_destroy: true

  scope :ordered_by_name, -> { order(:en_name) }

  validates :en_name, :uk_name, presence: true
  validates :en_name, :uk_name, length: { minimum: 3, maximum: 50 }
  validates :slug, presence: true, uniqueness: true
  validates :en_notes, :uk_notes,
            length: {
              maximum: 500,
              tokenizer: :strip_tags_and_tokenize
            }
  validates :color, format: { with: /\A#[0-9a-fA-F]{6}\z/ }

  scope :order_by_name, ->(order_direction) {
    direction      = (order_direction == "desc") ? :desc : :asc
    localized_name = localized_column_for(:name)

    order(localized_name => direction)
  }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "preferable", "slug", "updated_at", "uuid"]
  end

  ransacker :name do |parent, _args|
    locale_case = Arel::Nodes::Case.new
    locale_case.when(Arel::Nodes::SqlLiteral.new("'#{I18n.locale}' = 'uk'")).then(parent.table[:uk_name])
    locale_case.else(parent.table[:en_name])
    locale_case
  end

  def strip_tags_and_tokenize(string)
    ActionController::Base.helpers.strip_tags(string).chars
  end

  def logo_url
    if logo_picture.attached?
      Rails.application.routes.url_helpers.rails_blob_url(logo_picture, only_path: true)
    else
      # Default image
      "scales.png"
    end
  end
end
