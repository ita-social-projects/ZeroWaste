class FieldValidator < ActiveModel::Validator
  def validate(record)
    field_is_part_of_any_formula(record)
  end

  private

  def field_is_part_of_any_formula(record)
    used_in_any_formula  = record.calculator.formulas.any? do |formula|
      formula.expression.scan(/\b[a-zA-Z_]\w*\b/).uniq.include?(record.var_name)
    end

    return if used_in_any_formula

    record.errors.add(:var_name, "field isn't used in any formula")
  end
end
