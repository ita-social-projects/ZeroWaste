# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
