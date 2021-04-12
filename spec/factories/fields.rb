FactoryBot.define do
  factory :field do
    calculator_id { 1 }
    selector { "" }
    type { "parameter" }
    label { "Label" }
    kind { 0 }
  end
end
