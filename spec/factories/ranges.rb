FactoryBot.define do
  factory :range do
    from { 0 }
    type { 'Calculation' }
    label { 'Label' }
    kind { 'form' }
    calculator
    #to { 200 }
    #value { '10' }
  end
end
