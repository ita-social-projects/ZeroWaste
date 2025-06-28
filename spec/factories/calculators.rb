# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  color      :string           default("#000000")
#  en_name    :string           default(""), not null
#  slug       :string
#  uk_name    :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_calculators_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :calculator do
    en_name { "English Calculator" }
    uk_name { "Український калькулятор" }

    trait :with_field_and_formula do
      after(:build) do |calculator|
        calculator.fields << build(:field, var_name: "x", calculator: calculator)
        calculator.formulas << build(:formula, expression: "x+1", calculator: calculator)
      end
    end
  end
end
