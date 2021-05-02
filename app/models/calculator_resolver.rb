# frozen_string_literal: true

class CalculatorResolver
  def self.call(calculator)
    dependencies = {}
    get_calculations(calculator).each do |field|
      dependencies[field] = if field[:type] == 'Calculation'
                              get_dependencies(field[:value])
                            else
                              []
                            end
    end

    dependencies
  end

  def self.get_dependencies(value)
    calculator = Dentaku::Calculator.new
    calculator.dependencies(value)
  end

  def self.get_calculations(calculator)
    Field.where(calculator_id: calculator.id, kind: 'result')
  end
end
