class Formula < ApplicationRecord
  belongs_to :calculator

  validates_with FormulaValidator
end
