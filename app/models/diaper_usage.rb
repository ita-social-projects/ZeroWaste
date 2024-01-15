class DiaperUsage < ApplicationRecord
  belongs_to :life_period
  has_many :prices, as: :priceable, dependent: :destroy

  validates :quantity_per_day, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
