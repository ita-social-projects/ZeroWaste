FactoryBot.define do
  factory :field do
    type { "parameter" }
    label { "Label" }
    kind { "form" }
    association :calculator, factory: :calculator, strategy: :build
  end
end
