# frozen_string_literal: true

require 'functions/items_per_month'
require 'functions/since'

class CalculationResolver
  attr_reader :calculator

  def initialize
    @calculator = Dentaku::Calculator.new
    @calculator.add_function(:since, :numeric, Since.calculate_units)
    @calculator.add_function(:items_per_month, :numeric, ItemsPerMonth.deferred)
  end

  def result(parameters, value)
    calculator.evaluate(
      value,
      calculator.dependencies(value).each_with_object({}) do |key, hash|
        hash[key.to_sym] = key
      end.merge(parameters)
      )
  end
end
