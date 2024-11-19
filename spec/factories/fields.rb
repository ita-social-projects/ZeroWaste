# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  en_label      :string           default(""), not null
#  field_type    :string           default(""), not null
#  uk_label      :string           default(""), not null
#  var_name      :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#
FactoryBot.define do
  factory :field do
    kind { "number" }
    en_label { "Label" }
    uk_label { "Label" }
    var_name { "var" }
    calculator
  end
end
