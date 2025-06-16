class Period < ApplicationRecord
  belongs_to :category

  validates :period_start, presence: true
  validates :period_end, presence: true
end
