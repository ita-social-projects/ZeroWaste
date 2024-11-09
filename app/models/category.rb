# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  priority   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  preferable :boolean          default: false
#
class Category < ApplicationRecord
  belongs_to :field

  validates :uk_name, :en_name, presence: true
  validates :uk_name, :en_name,
            length: { minimum: 3, maximum: 30 },
            format: { with: /\A[\p{L}0-9\s'-]+\z/i },
            uniqueness: { case_sensitive: false },
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
end
