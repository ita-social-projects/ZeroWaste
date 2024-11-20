FactoryBot.define do
  factory :formula do
    association :calculator
    expression { "a + b" }
    en_label { "Sum" }
  end
end
