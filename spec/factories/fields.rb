# frozen_string_literal: true

FactoryBot.define do
  factory :field do
    type { 'Calculation' }
    label { 'Label' }
    kind { 'form' }
    calculator
  end
end
