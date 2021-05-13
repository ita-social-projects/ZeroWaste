# frozen_string_literal: true

require 'functions/since'
require 'functions/from_list'

class CalculatorResolver
  def self.call(calculator)
    get_fields(calculator).each_with_object({}) do |field, hash|
      unless field[:type] == 'Calculation'
        hash[field] = []
        next
      end
      hash[field] = get_dependencies(field[:value])
    end
  end

  def self.result(parameters, value)
    calculator = generate_calculator
    generate_since_function(calculator)
    generate_from_list_function(calculator)
    calculator.evaluate(value, parameters)
  end

  def self.get_dependencies(value)
    selectors = generate_calculator.dependencies(value)
    selectors.map!(&:upcase)
    Value.where(selector: selectors)
  end

  def self.get_fields(calculator)
    calculator.fields.result
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
    private :get_dependencies, :get_fields, :generate_calculator,
            :generate_since_function, :generate_from_list_function
  end
end
