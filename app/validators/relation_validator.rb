class RelationValidator < ActiveModel::Validator
  def validate(record)
    relation_is_correct(record)
  end

  private

  def relation_is_correct(record)
    return if record.formulas.blank?

    if record.formulas.first.relation == "previous"
      record.formulas.first.errors.add(:relation, I18n.t("activerecord.errors.models.formula.attributes.expression.first_relation_error"))
    end

    if record.formulas.last.relation == "next"
      record.formulas.last.errors.add(:relation, I18n.t("activerecord.errors.models.formula.attributes.expression.last_relation_error"))
    end

    last_relation             = nil
    last_formula_has_relation = false

    record.formulas.each do |formula|
      if last_relation == "next" && formula.relation == "previous"
        formula.errors.add(:relation, I18n.t("activerecord.errors.models.formula.attributes.expression.relation_between_two_error"))
      end

      if last_formula_has_relation && formula.relation == "previous" || last_relation == "next" && formula.relation == "next"
        formula.errors.add(:relation, I18n.t("activerecord.errors.models.formula.attributes.expression.already_have_relation_error"))
      end

      last_formula_has_relation = formula.relation.present? || last_relation == "next"

      last_relation = formula.relation
    end

    if record.formulas.any? { |formula| formula.errors.present? }
      record.errors.add(:formulas, "contain invalid relations.")
    end
  end
end
