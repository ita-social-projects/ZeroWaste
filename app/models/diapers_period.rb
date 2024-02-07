class DiapersPeriod < ApplicationRecord
  belongs_to :category

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :period_start, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :period_end, presence: true, numericality: { only_integer: true, greater_than: :period_start }
  validates :usage_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
