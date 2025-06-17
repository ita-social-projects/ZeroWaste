FactoryBot.define do
  factory :select_option do
    association :field
    key { "MyString" }
    value { 1 }
  end
end
