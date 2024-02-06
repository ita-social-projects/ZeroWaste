class DiapersPeriod < ApplicationRecord
  belongs_to :category

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :period_start, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :period_end, presence: true, numericality: { only_integer: true, greater_than: :period_start }
  validates :usage_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # validate :period_does_not_overlap

  private

  def period_does_not_overlap
    overlapping_period = DiapersPeriod.where(category_id: category_id)
                                      .where.not(id: id)
                                      .exists?(["period_start <= ? AND period_end >= ?", period_start, period_start])
    errors.add(:period_start, "overlaps with an existing period") if overlapping_period
  end
end
