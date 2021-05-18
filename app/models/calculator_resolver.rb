# frozen_string_literal: true

class CalculatorResolver
  def self.call(calculator)
    get_fields(calculator).each_with_object({}) do |field, hash|
      unless field[:type] == 'Calculation'
        hash[field] = []
        next
      end
      values_list = dependencies_list(field[:value])
      hash[field] = get_dependencies(values_list)
    end
  end

  def self.get_dependencies(values_list)
    dependencies_objects = []
    if get_dependencies_values(values_list).present?
      get_dependencies_values(values_list).each do |value|
        dependencies_objects << value
      end
    end

    unless get_dependencies_calculations(values_list).present?
      return dependencies_objects
    end

    get_dependencies_calculations(values_list).each do |nested_calculation|
      nested_values_list = dependencies_list(nested_calculation[:value])
      dependencies_objects += get_dependencies(nested_values_list)
    end

    dependencies_objects
  end

  def self.dependencies_list(value)
    calculator = Dentaku::Calculator.new
    selectors = calculator.dependencies(value)
    selectors.map!(&:upcase)
  end

  def self.get_dependencies_values(value)
    selectors = dependencies_list(value)
    Value.where(selector: selectors)
  end

  def self.get_dependencies_calculations(value)
    selectors = dependencies_list(value)
    Calculation.where(selector: selectors)
  end

  def self.get_fields(calculator)
    calculator.fields.result
  end

  class << self
    private :get_dependencies, :get_dependencies_values,
            :get_dependencies_calculations, :dependencies_list,
            :get_fields
  end
end
