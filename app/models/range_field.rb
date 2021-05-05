# frozen_string_literal: true

class RangeField < Field
  validates :from, :to, :value, presence: true
  validates :value, length: { minimum: 1 }
  validates :from, :to, numericality: { only_integer: true }

  def result(parameters)
    calculator = Dentaku::Calculator.new
    calculator.add_function(:from_list, :numeric, InClass.calculate_params)
    calculator.evaluate(value, parameters)
  end
end
