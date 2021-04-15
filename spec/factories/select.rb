FactoryBot.define do
  factory :select do
    value { 'Select' }
    type { 'Calculation' }
    label { 'Label' }
    kind { 'form' }
    calculator
  end
end
