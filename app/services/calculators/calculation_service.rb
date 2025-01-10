class Calculators::CalculationService
  def initialize(calculator, inputs)
    @calculator = calculator
    @inputs     = inputs.to_unsafe_h

    @dentaku = Dentaku::Calculator.new
  end

  def perform
    @calculator.formulas.map do |formula|
      result = @dentaku.evaluate(formula.expression, @inputs).round(2)

      { label: formula.label, result: result, unit: formula.unit, formula_image: formula.formula_image }
    end
  end
end
