class Formula < ApplicationRecord
  belongs_to :calculator

  validates_with FormulaValidator

  validates :uk_label, :en_label, :uk_unit, :en_unit, :expression, presence: true
  validates :uk_label, :en_label, length: { minimum: 3, maximum: 50 }
  validates :en_unit, :uk_unit, length: { minimum: 1, maximum: 30 }
end
