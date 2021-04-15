FactoryBot.define do
  factory :select do
    value { 'Selec' }
    type { 'Calculation' }
    label { 'Label' }
    kind { 'form' }
    calculator
  end
end
