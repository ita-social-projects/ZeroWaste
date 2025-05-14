class Calculators::Api::V2::CalculationService
  attr_reader :results

  def initialize(calculator, params)
    @calculator = calculator
    @params     = params.to_unsafe_h
    @results    = {}

    @dentaku = Dentaku::Calculator.new
  end

  def perform
    @calculator.formulas.map do |formula|
      result                     = @dentaku.evaluate(formula.expression, @params).round(2)
      @results[formula.uk_label] = result
    end
  end
end
