# == Schema Information
#
# Table name: formulas
#
#  id            :bigint           not null, primary key
#  en_label      :string           not null
#  en_unit       :string
#  expression    :string           default(""), not null
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
FactoryBot.define do
  factory :formula do
    en_label { "Label" }
    uk_label { "Label" }
    uk_unit { "шт." }
    en_unit { "pcs." }
    expression { "x + y" }
    calculator
  end
end
