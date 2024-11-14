class FormulaValidator < ActiveModel::Validator
  FORMULA_VARIABLES_REGEX = /\b[a-zA-Z_]\w*\b/

  def validate(record)
    fields_are_included_in_formulas(record)
    expression_is_mathematically_valid(record)
  end

  private

  def fields_are_included_in_formulas(record)
    return if record.calculator.blank?

    field_names       = record.calculator.fields.map(&:var_name)
    formula_variables = record.expression.scan(FORMULA_VARIABLES_REGEX).uniq
    unused_fields     = formula_variables.reject { |var| field_names.include?(var) }

    return if unused_fields.blank?

    record.errors.add(:expression, :uninitialized_fields, fields: unused_fields.join(", "), count: unused_fields.count)
  end

  def expression_is_mathematically_valid(record)
    begin
      Dentaku::Parser.new(Dentaku::Tokenizer.new.tokenize(record.expression)).parse
    rescue Dentaku::ParseError, Dentaku::TokenizerError
      record.errors.add(:expression, :mathematically_invalid)
    end
  end
end
