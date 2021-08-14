# frozen_string_literal: true

class RangeField < Field
  validates :from, :to, :value, presence: true
  validates :value, length: { minimum: 1 }
  validates :from, :to, numericality: { only_integer: true }
end
