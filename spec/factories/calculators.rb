# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
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
    uk_name { "Український калькуялтор" }

    after(:create) do |calculator|
      calculator.fields << build(:field, calculator: calculator, var_name: 'a')
      calculator.fields << build(:field, calculator: calculator, var_name: 'b')

      calculator.formulas << build(:formula, calculator: calculator, expression: 'a + b', en_label: 'Sum')
      calculator.formulas << build(:formula, calculator: calculator, expression: 'a * b', en_label: 'Product')
    end
  end
end
