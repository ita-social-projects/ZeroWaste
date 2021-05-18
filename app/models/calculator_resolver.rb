# frozen_string_literal: true

class CalculatorResolver
  def self.call(calculator)
    get_fields(calculator).each_with_object({}) do |field, hash|
      unless field[:type] == 'Calculation'
        hash[field] = []
        next
      end
      upcased_dependencies = upcase_dependencies(field[:value])
      hash[field] = all_dependent_values(upcased_dependencies)
    end
  end

  def self.all_dependent_values(dependencies)
    dependencies_values = []
    if dependent_values(dependencies).present?
      dependent_values(dependencies).each do |value|
        dependencies_values << value
      end
    end

    unless dependent_calculations(dependencies).present?
      return dependencies_values
    end

    dependent_calculations(dependencies).each do |nested_calculation|
      nested_dependencies = upcase_dependencies(nested_calculation[:value])
      dependencies_values += all_dependent_values(nested_dependencies)
    end

    dependencies_values
  end

  def self.upcase_dependencies(value)
    calculator = Dentaku::Calculator.new
    selectors = calculator.dependencies(value)
    selectors.map!(&:upcase)
  end

  def self.dependent_values(value)
    selectors = upcase_dependencies(value)
    Value.where(selector: selectors)
  end

  def self.dependent_calculations(value)
    selectors = upcase_dependencies(value)
    Calculation.where(selector: selectors)
  end

  def self.get_fields(calculator)
    calculator.fields.result
  end

  class << self
    private :all_dependent_values, :dependent_values,
            :dependent_calculations, :upcase_dependencies,
            :get_fields
  end
end
