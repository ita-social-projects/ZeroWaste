FactoryBot.define do
  factory :category do
    trait :budgetary do
      name { "budgetary" }
    end

    trait :medium do
      name { "medium" }
    end
  end
end
