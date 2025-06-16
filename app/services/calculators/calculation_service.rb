class Calculators::CalculationService
  def initialize(calculator, inputs)
    @calculator = calculator
    @inputs     = parse_json_arrays(inputs)

    @dentaku = Dentaku::Calculator.new
  end

  def perform
    @calculator.formulas.map do |formula|
      result = @dentaku.evaluate(formula.expression, @inputs)
      {
        label: formula.label,
        result: result,
        unit: formula.unit,
        relation: formula.relation
      }
    end
  end

  private

  def parse_json_arrays(inputs)
    hash = inputs.is_a?(ActionController::Parameters) ? inputs.to_unsafe_h : inputs.to_h
    hash.transform_values do |value|
      if value.is_a?(String) && value.strip.start_with?("[") && value.strip.end_with?("]")
        begin
          JSON.parse(value)
        rescue JSON::ParserError
          value
        end
      else
        value
      end
    end
  end
end
