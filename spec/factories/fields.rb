FactoryBot.define do
  factory :field do
    uuid { "85d529ed-d9a1-4422-9bd0-93ecb8bc6609" }
    selector { "P1" }
    type { "parameter" }
    label { "Label" }
    kind { "form" }
    association :calculator, factory: :calculator, strategy: :build
  end

  factory :calculator do
    uuid { "2b94a291-bfd6-4a6a-a944-10d2989896c4" }
    name { "calc_test" }
  end
end
