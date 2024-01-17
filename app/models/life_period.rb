class LifePeriod < ApplicationRecord
  has_many :diaper_usages, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :month_range, presence: true

  def month_range=(month)
    self[:month_range] = month.map(&:to_i)
  end

  def include_month?(month)
    month_range.include?(month.to_i)
  end
end
