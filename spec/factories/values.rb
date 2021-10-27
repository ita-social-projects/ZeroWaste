# frozen_string_literal: true

FactoryBot.define do
  factory :value do
    value { 'Value' }
    type { 'Value' }
    label { 'Label' }
    kind { 'form' }
    calculator
  end
end
