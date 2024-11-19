# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  en_label      :string           default(""), not null
#  kind          :string           not null
#  uk_label      :string           default(""), not null
#  unit          :integer          default("day")
#  var_name      :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#
# Foreign Keys
#
#  fk_rails_...  (calculator_id => calculators.id)
#
class FieldSerializer < ActiveModel::Serializer
  attributes :name, :result

  def name
    object.name.parameterize.underscore
  end

  # rubocop:disable Metrics/AbcSize
  def result
    cal_res = CalculatorResolver.call(object.calculator)
    res     = cal_res.each_with_object({}) do |(key, value), result|
      result[key[:value]] = value.each_with_object({}) do |v, sel|
        sel[v[:selector].downcase] = v[:value]
      end
    end
    result  = res.each_with_object({}) do |(formula, parameters), new_hash|
      new_hash[formula] = CalculationResolver.new.result(parameters, formula)
    end
    answer  = result.each_with_object([]) do |(_, calculated_formula), new_array|
      new_array << calculated_formula
    end
    number  = ""
    (0..answer.count).each do |el|
      number = answer[el] if object.selector == "R#{el + 1}"
    end
    number
  end
  # rubocop:enable Metrics/AbcSize
end
