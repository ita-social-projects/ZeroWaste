class Period < ApplicationRecord
  belongs_to :category

  validates :period_start, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :period_end, presence: true, numericality: { only_integer: true, greater_than: :period_start }
  validates :usage_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
end
