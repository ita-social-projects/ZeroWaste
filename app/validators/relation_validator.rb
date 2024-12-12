class RelationValidator < ActiveModel::Validator
  def validate(record)
    relation_is_correct(record)
  end

  private

  def relation_is_correct(record)
    return if record.formulas.blank?

    if record.formulas.first.relation == "previous"
      record.formulas.first.errors.add(:relation, "The first formula cannot have a relation of 'Previous' because there is no previous formula.")
    end

    if record.formulas.last.relation == "next"
      record.formulas.last.errors.add(:relation, "The last formula cannot have a relation of 'Next' because there is no next formula.")
    end

    last_relation = nil
    record.formulas.each do |formula|
      if last_relation == "next" && formula.relation == "previous"
        formula.errors.add(:relation, "cannot have the same relation as the previous formula.")
      end
      last_relation = formula.relation
    end

    if record.formulas.any? { |formula| formula.errors.present? }
      record.errors.add(:formulas, "contain invalid relations.")
    end
  end
end
