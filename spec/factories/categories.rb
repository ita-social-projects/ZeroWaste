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
    en_name { "category" }
    uk_name { "категорія" }

    trait :budgetary do
      en_name { "budgetary" }
      uk_name { "бюджетна" }

      after(:create) do |category|
        create(:diapers_period, category: category)
      end
    end

    trait :medium do
      en_name { "medium" }
      uk_name { "середня" }
      preferable { true }

      after(:create) do |category|
        create(:diapers_period, category: category)
      end
    end

    trait :without_diapers_period do
      en_name { "without-diapers-period" }
      uk_name { "без-diapers-period" }
    end
  end
end
