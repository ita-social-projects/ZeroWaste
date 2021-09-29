# frozen_string_literal: true

class FieldSerializer < ActiveModel::Serializer
  attributes :name, :result

  def name
    object.name.parameterize.underscore
  end

  def result
    cal_res = CalculatorResolver.call(object.calculator)
    res = cal_res.each_with_object({}) do |(key, value), result|
      result[key[:value]] = value.each_with_object({}) do |v, sel|
        sel[v[:selector].downcase] = v[:value]
      end
    end
    result = res.each_with_object({}) do |(formula, parameters), result|
      result[formula] = CalculationResolver.result(parameters, formula)
    end
    answer = result.each_with_object([]) do |(_, calculated_formula), answer|
      answer << calculated_formula
    end
    number = ''
    (0..answer.count).each do |el|
      number = answer[el] if object.selector == "R#{el + 1}"
    end
    number
  end
end
