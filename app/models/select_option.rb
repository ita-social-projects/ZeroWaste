class SelectOption < ApplicationRecord
  belongs_to :field

  validates :key, presence: true
  validates :value, presence: true
end
