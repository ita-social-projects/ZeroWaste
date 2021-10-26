# frozen_string_literal: true

require 'functions/items_per_month'
require 'functions/since'

class CalculationResolver
  def self.result(parameters, value)
    calculator = Dentaku::Calculator.new
    calculator.add_function(:since, :numeric, Since.calculate_units)
    calculator.add_function(:items_per_month, :numeric, ItemsPerMonth.deferred)
    calculator.evaluate(
      value,
      calculator.dependencies(value).each_with_object({}) do |i, res|
        res[i.to_sym] = i
      end.merge(parameters)
    )
  end
end
