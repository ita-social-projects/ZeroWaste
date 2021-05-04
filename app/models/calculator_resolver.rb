# frozen_string_literal: true

class CalculatorResolver
  def self.call(calculator)
    dependencies = {}
    get_fields(calculator).each do |field|
      unless field[:type] == 'Calculation'
        dependencies[field] = []
        next
      end
      dependencies[field] = get_dependencies(field[:value])
    end

    dependencies
  end

  def self.get_dependencies(value)
    fetched_values = []
    calculator = Dentaku::Calculator.new
    selectors = calculator.dependencies(value)
    selectors.each do |selector|
      fetched_values << Value.where(selector: selector.upcase)[0]
    end

    fetched_values
  end

  def self.get_fields(calculator)
    Field.joins(:calculator)
         .where(calculator_id: calculator.id, kind: 'result')
  end
end
