class Calculators::CalculationService
  include ApplicationHelper

  def initialize(calculator, inputs)
    @calculator = calculator
    @inputs     = inputs.to_unsafe_h

    @dentaku = Dentaku::Calculator.new
  end

  def perform
    @calculator.formulas.map do |formula|
      result = @dentaku.evaluate(formula.expression, @inputs)

      if current_locale?(:en)
        { label: formula.en_label, result: result, en_unit: formula.en_unit }
      else
        { label: formula.uk_label, result: result, en_unit: formula.uk_unit }
      end
    end
  end
end
