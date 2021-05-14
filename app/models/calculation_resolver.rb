# frozen_string_literal: true

class CalculationResolver
  require 'functions/from_list'

  def self.result(parameters, value)
    calculator = generate_calculator
    generate_since_function(calculator)
    generate_from_list_function(calculator)
    calculator.evaluate(value, parameters)
  end

  def self.generate_calculator
    Dentaku::Calculator.new
  end

  def self.generate_since_function(calculator)
    calculator.add_function(:since, :numeric, Since.calculate_units)
  end

  def self.generate_from_list_function(calculator)
    calculator.add_function(:from_list, :numeric, FromList.to_hash)
  end

  class << self
    private :generate_calculator, :generate_since_function,
            :generate_from_list_function
  end
end
