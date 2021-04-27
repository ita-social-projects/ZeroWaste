# frozen_string_literal: true

class Calculation < Field
  validates_presence_of :value
  validates :value, length: { minimum: 2 }

  def result(value, parameters = {})
    hash_of_parameters = parameters
    formula = value
    calculator = Dentaku::Calculator.new
    calculator.evaluate(formula, hash_of_parameters)
  end
end

calc = Calculation.new
calc.result('P1 + 2', { P1: params[:P1], P2: params[:P2] })
