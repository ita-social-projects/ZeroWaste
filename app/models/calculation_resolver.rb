# frozen_string_literal: true

class CalculationResolver
  require 'functions/from_list'

  def self.result(parameters, value)
    calculator = Dentaku::Calculator.new
    calculator.add_function(:since, :numeric, Since.calculate_units)
    calculator.add_function(:from_list, :numeric, FromList.to_hash)
    calculator.evaluate(value, parameters)
  end
end
