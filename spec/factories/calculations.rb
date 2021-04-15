FactoryBot.define do
  factory :calculation do
    value { 'F1 * P2 / P5' }
    type { 'Calculation' }
    label { 'Label' }
    kind { 'form' }
    calculator
  end
end
