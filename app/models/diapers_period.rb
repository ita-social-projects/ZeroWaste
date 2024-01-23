class DiapersPeriod < ApplicationRecord
  belongs_to :category

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :period_start, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :period_end, presence: true, numericality: { only_integer: true, greater_than: :period_start }
  validates :usage_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate :period_does_not_overlap


  private

  def period_does_not_overlap
    return unless category.diapers_periods.where.not(id: id).overlaps(period_start, period_end).exists?

    errors.add(:period_end, :overlaps)
  end

  # def period_does_not_overlap
  #   overlapping_period = DiapersPeriod.where("period_start <= ? AND period_end >= ?", period_start, period_start).exists?
  #   errors.add(:period_start, 'overlaps with an existing period') if overlapping_period
  # end

  # def period_does_not_overlap
  #   if category && category.diapers_periods.exists?(['(period_start <= ? AND period_end >= ?) OR (period_start >= ? AND period_end <= ?)', period_end, period_start, period_start, period_end])
  #     errors.add(:base, 'Period overlaps with existing periods')
  #   end
  # end
end
