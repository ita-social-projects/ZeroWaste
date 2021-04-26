# frozen_string_literal: true

class Calculation < Field
  validates_presence_of :value
  validates :value, length: { minimum: 2 }

  def result()
    hash_of_parameters = {P1: params[:P1], P2: params[:P2]}
    formula = value
    calculator = Dentaku::Calculator.new
    calculator.evaluate(formula, hash_of_parameters)
    # hash_of_parameters = {P1: 1, P2: 3}
    # formula = P1 + 2
  end
end
