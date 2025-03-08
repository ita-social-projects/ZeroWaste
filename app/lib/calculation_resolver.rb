# frozen_string_literal: true

require "functions/items_per_month"
require "functions/since"

class CalculationResolver
  attr_reader :calculator

  def initialize
    @calculator = Dentaku::Calculator.new
    @calculator.add_function(:since, :numeric, Functions::Since.calculate_units)
    @calculator.add_function(:items_per_month, :numeric, Functions::ItemsPerMonth.deferred)
  end

  def result(parameters, value)
    calculator.evaluate(
      value,
      calculator.dependencies(value).index_by do |key|
        key.to_sym
      end.merge(parameters)
    )
  end
end
