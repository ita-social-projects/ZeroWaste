# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  uuid          :uuid             not null
#  calculator_id :bigint           not null
#  selector      :string           not null
#  type          :string           not null
#  label         :string
#  name          :string
#  value         :string
#  from          :integer
#  to            :integer
#  kind          :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  unit          :integer          default("day")
#
FactoryBot.define do
  factory :named_value do
    name { 'NamedValue' }
    type { 'Calculation' }
    label { 'Label' }
    kind { 'form' }
    from { 0 }
    to { 200 }
    calculator
  end
end
