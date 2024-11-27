# == Schema Information
#
# Table name: formulas
#
#  id            :bigint           not null, primary key
#  en_label      :string           default(""), not null
#  en_unit       :string
#  expression    :string           default(""), not null
#  priority      :integer          default(0), not null
#  uk_label      :string           default(""), not null
#  uk_unit       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_formulas_on_calculator_id  (calculator_id)
#
# Foreign Keys
#
#  fk_rails_...  (calculator_id => calculators.id)
#
class Formula < ApplicationRecord
  belongs_to :calculator

  validates_with FormulaValidator

  validates :uk_label, :en_label, :uk_unit, :en_unit, :expression, presence: true
  validates :uk_label, :en_label, length: { minimum: 3, maximum: 50 }
  validates :en_unit, :uk_unit, length: { minimum: 1, maximum: 30 }
end
