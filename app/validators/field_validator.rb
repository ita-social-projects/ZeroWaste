class FieldValidator < ActiveModel::Validator
  FORMULA_VARIABLES_REGEX = /\b[a-zA-Z_]\w*\b/

  def validate(record)
    field_is_part_of_any_formula(record)
  end

  private

  def field_is_part_of_any_formula(record)
    return if record.calculator.blank?

    used_in_any_formula  = record.calculator.formulas.any? do |formula|
      formula.expression.scan(FORMULA_VARIABLES_REGEX).uniq.include?(record.var_name)
    end

    return if used_in_any_formula

    record.errors.add(:var_name, :unused_in_formula)
  end
end
