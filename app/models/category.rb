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
#
class Category < ApplicationRecord
  has_one :price, dependent: :destroy
  has_many :diapers_periods, dependent: :destroy

  has_many :category_categoryables, dependent: :restrict_with_exception
  has_many :categoryables, through: :category_categoryables

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :priority, numericality: { greater_than_or_equal_to: 0 }

  scope :ordered_by_name, -> { order(:name) }
  scope :ordered_by_priority, -> { order(:priority) }
  scope :unsigned_categories, ->(product) { where.not(id: product.categories_by_prices) }

  scope :available_categories, -> { left_outer_joins(:diapers_periods).where(diapers_periods: { category_id: nil }).distinct }
  scope :categories_with_periods, -> { joins(:diapers_periods).distinct }
  scope :unfilled_categories, -> {
                                left_joins(:diapers_periods)
                                  .group(:id)
                                  .having("MAX(diapers_periods.period_end) IS NULL OR MAX(diapers_periods.period_end) < ?", 30)
                              }
  def self.preferable
    find_by(preferable: true)
  end
end
