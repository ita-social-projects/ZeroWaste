# frozen_string_literal: true

require 'functions/from_list'
require 'functions/diapers_per_month'
require 'functions/since'

class CalculationResolver
  def self.result(parameters, value)
    calculator = Dentaku::Calculator.new
    calculator.add_function(:since, :numeric, Since.calculate_units)
    calculator.add_function(:from_list, :numeric, FromList.to_hash)
    calculator.add_function(:dipers_per_month, :numeric, DiapersPerMonth.call)
    calculator.evaluate(value, parameters)
  end
end
