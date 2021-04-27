# frozen_string_literal: true

class Calculation < Field
  validates_presence_of :value
  validates :value, length: { minimum: 2 }

  def result(parameters)
    calculator = Dentaku::Calculator.new
    calculator.evaluate(value, parameters)
  end
end
