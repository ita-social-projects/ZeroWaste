class Calculators::CalculationService
  def initialize(calculator, inputs)
    @calculator = calculator
    @inputs     = inputs.to_unsafe_h

    @inputs = @inputs.transform_values do |v|
      if v.is_a?(String) && v.match?(/\A-?\d+(\.\d+)?\z/)
        v.include?(".") ? v.to_f : v.to_i
      else
        v
      end
    end

    @dentaku = Dentaku::Calculator.new
  end

  def perform
    @calculator.formulas.map do |formula|
      result = @dentaku.evaluate(formula.expression, @inputs).round(2)
      {
        label: formula.label,
        result: result,
        unit: formula.unit,
        relation: formula.relation
      }
    end
  end
end
