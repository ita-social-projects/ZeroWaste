FactoryBot.define do
  factory :value do
    value { 'Value' }
    type { 'Calculation' }
    label { "Label" }
    kind { 'form' }
    calculator
  end
end
