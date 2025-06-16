# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  en_name    :string
#  preferable :boolean          default(FALSE), not null
#  price      :decimal(10, 2)   default(0.0), not null
#  priority   :integer          default(0), not null
#  uk_name    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :bigint           not null
#
# Indexes
#
#  index_categories_on_field_id  (field_id)
#
# Foreign Keys
#
#  fk_rails_...  (field_id => fields.id)
#
class Category < ApplicationRecord
  include Translatable
  translates :name

  PRIORITY_RANGE = 0..10

  belongs_to :field, optional: true
  has_many :diapers_periods, dependent: :destroy
  has_many :category_categoryables, dependent: :restrict_with_exception
  has_many :periods, dependent: :destroy

  enum :preferable, { not_preferable: false, preferable: true }

  validates :uk_name, :en_name, presence: true
  validates :uk_name, :en_name,
            length: { minimum: 3, maximum: 30 },
            format: { with: /\A[\p{L}0-9\s'-]+\z/i },
            allow_blank: true
  validates :priority, numericality: { greater_than_or_equal_to: 0 }

  scope :ordered_by_name, -> { order(:uk_name) }
  scope :ordered_by_priority, -> { order(:priority) }
  scope :unsigned_categories, ->(product) { where.not(id: product.categories_by_prices) }

  scope :without_diapers_periods, -> { left_outer_joins(:diapers_periods).where(diapers_periods: { category_id: nil }).distinct }
  scope :with_diapers_periods, -> { joins(:diapers_periods).distinct }
  scope :with_unfilled_diapers_periods, -> {
    left_joins(:diapers_periods)
      .group(:id)
      .having("MAX(diapers_periods.period_end) IS NULL OR MAX(diapers_periods.period_end) < ?", 30)
  }

  scope :ordered_by_diapers_periods_price, -> {
    where.not(id: with_unfilled_diapers_periods)
         .joins(:diapers_periods)
         .group("categories.id")
         .order("MIN(diapers_periods.price) ASC")
  }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "#{I18n.locale}_name", "priority", "updated_at"]
  end

  accepts_nested_attributes_for :periods, reject_if: :all_blank, allow_destroy: true
end
