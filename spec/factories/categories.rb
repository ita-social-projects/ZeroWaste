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
    end

    trait :medium do
      name { "medium" }
    end

    trait :preferable do
      name { "preferable" }
      preferable { :preferable }
    end

    trait :without_diapers_period do
      name { "without-diapers-period" }

      after(:create) do |category|
        category.diapers_periods.clear
      end
    end

    after(:create) do |category|
      create(:diapers_period, category: category)
    end
  end
end
