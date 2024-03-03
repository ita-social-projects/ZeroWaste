# == Schema Information
#
# Table name: diapers_periods
#
#  category_id :bigint          null: false
#  price :decimal               precision: 8, scale: 2
#  period_start :integer        null: false
#  period_end :integer          null: false
#  usage_amount :integer        null: false
#  created_at :datetime         null: false
#  updated_at :datetime         null: false
#  index ["category_id"], name: "index_diapers_periods_on_category_id"

class DiapersPeriod < ApplicationRecord
  belongs_to :category

  validates :price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :period_start,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validates :period_end,
            presence: true,
            numericality: { only_integer: true, greater_than: :period_start, less_than_or_equal_to: 30 }

  validates :usage_amount,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  def self.categories_with_periods
    Category.joins(:diapers_periods).group(:id).order("MIN(diapers_periods.price) ASC")
  end

  def self.available_categories
    Category.left_outer_joins(:diapers_periods).where(diapers_periods: { category_id: nil }).distinct
  end

  def self.unfilled_categories
    Category.left_outer_joins(:diapers_periods)
            .group(:id)
            .having("MAX(diapers_periods.period_end) IS NULL OR MAX(diapers_periods.period_end) < ?", 30)
  end

  def self.ordered_categories
    Category.where.not(id: DiapersPeriod.unfilled_categories)
            .joins(:diapers_periods)
            .group(:id)
            .order("MIN(diapers_periods.price) ASC")
  end

  def self.start_date(category)
    last_period = category.diapers_periods.order(:created_at).last
    last_period ? (last_period.period_end + 1) : 1
  end
end
