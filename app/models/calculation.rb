# frozen_string_literal: true

require 'functions/since'

class Calculation < Field
  validates_presence_of :value
  validates :value, length: { minimum: 2 }

  def result(parameters)
    calculator = Dentaku::Calculator.new
    calculator.add_function(:since, :numeric, Since.calculate_units)
    calculator.evaluate(value, parameters)
  end
end
