class SelectOption < ApplicationRecord
  belongs_to :field

  validates :key, presence: true, length: { maximum: 50 }
  validates :value, presence: true, numericality: true
end
