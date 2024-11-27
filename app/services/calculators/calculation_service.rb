class Calculators::CalculationService
  def initialize(calculator, inputs)
    @calculator = calculator
    @inputs     = inputs.to_unsafe_h

    @dentaku = Dentaku::Calculator.new
  end

  def perform
    @calculator.formulas.map do |formula|
      result = @dentaku.evaluate(formula.expression, @inputs)

      { label: formula.label, result: result, unit: formula.unit }
    end
  end
end
