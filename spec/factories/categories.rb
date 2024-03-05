# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  priority   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :category do
    name { "name" }

    trait :budgetary do
      name { "budgetary" }

      after(:create) do |category|
        create(:diapers_period, category: category)
      end
    end

    trait :medium do
      name { "medium" }
      preferable { true }

      after(:create) do |category|
        create(:diapers_period, category: category)
      end
    end

    trait :without_diapers_period do
      name { "without-diapers-period" }
    end
  end
end
