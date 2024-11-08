class FormulaValidator < ActiveModel::Validator
  def validate(record)
    fields_are_included_in_formulas(record)
  end

  private

  def fields_are_included_in_formulas(record)
    field_names = record.calculator.fields.map(&:var_name)
    formula_variables = record.expression.scan(/\b[a-zA-Z_]\w*\b/).uniq
    unused_fields = formula_variables.reject { |var| field_names.include?(var) }

    return if unused_fields.blank?

    record.errors.add(:expression, "requires fields #{unused_fields.join(', ')} to be initialized")
  end
end
