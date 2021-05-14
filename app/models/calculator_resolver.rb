# frozen_string_literal: true

require 'functions/since'

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

  def self.get_dependencies(value)
    calculator = Dentaku::Calculator.new
    selectors = calculator.dependencies(value)
    selectors.map!(&:upcase)
    Value.where(selector: selectors)
  end

  def self.get_fields(calculator)
    calculator.fields.result
  end

  class << self
    private :get_dependencies, :get_fields
  end
end
