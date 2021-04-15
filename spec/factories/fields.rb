FactoryBot.define do
  factory :field do
    type { "parameter" }
    label { "Label" }
    kind { "form" }
    association :calculator
  end
end
