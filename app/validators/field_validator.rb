class FieldValidator < ActiveModel::Validator
  FORMULA_VARIABLES_REGEX = /\b[a-zA-Z_]\w*\b/

  def validate(record)
    field_is_part_of_any_formula(record)
    var_name_is_unique_within_calculator(record)
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

  def var_name_is_unique_within_calculator(record)
    return if record.calculator.blank?

    fields = record.calculator.fields.map(&:var_name)
    duplicate_count = fields.count(record.var_name)

    return if duplicate_count <= 1

    record.errors.add(:var_name, :calculator_var_name_uniqueness, count: duplicate_count)
  end
end
