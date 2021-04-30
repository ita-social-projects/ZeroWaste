# frozen_string_literal: true

require 'functions/since'

class Calculation < Field
  validates_presence_of :value
  validates :value, length: { minimum: 2 }

  def result(parameters)
    calculator = Dentaku::Calculator.new
    return build_since_function(calculator, parameters) if value == 'since'

    calculator.evaluate(value, parameters)
  end

  def build_since_function(calculator, parameters)
    calculator.add_function(:since, :numeric, Since.calculate_units)
    from = parameters[:from].to_time
    to = parameters[:to].to_time
    unit = parameters[:unit]
    calculator.evaluate("SINCE(#{from}, #{to}, #{unit})")
  end
end
