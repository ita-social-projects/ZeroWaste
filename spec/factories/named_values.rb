# frozen_string_literal: true

FactoryBot.define do
  factory :named_value do
    name { 'NamedValue' }
    type { 'Calculation' }
    label { 'Label' }
    kind { 'form' }
    calculator
  end
end
