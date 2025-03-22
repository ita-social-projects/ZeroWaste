require "rails_helper"

RSpec.describe RelationValidator do
  let(:calculator) { build(:calculator) }

  describe "validations" do
    let(:formula_previous_relation) { build(:formula, relation: "previous") }
    let(:formula_next_relation) { build(:formula, relation: "next") }
    let(:formula_none_relation) { build(:formula, relation: nil) }

    context "when the first formula has a relation of previous" do
      before do
        calculator.formulas = [formula_previous_relation]
        calculator.valid?
      end

      it "adds an error to the first formula" do
        expect(formula_previous_relation.errors[:relation]).to include(I18n.t("activerecord.errors.models.formula.attributes.expression.first_relation_error"))
      end
    end

    context "when the last formula has a relation of next" do
      before do
        calculator.formulas = [formula_none_relation, formula_next_relation]
        calculator.valid?
      end

      it "adds an error to the last formula" do
        expect(formula_next_relation.errors[:relation]).to include(I18n.t("activerecord.errors.models.formula.attributes.expression.last_relation_error"))
      end
    end

    context "when formulas have consecutive relations 'next' and 'previous'" do
      before do
        calculator.formulas = [formula_next_relation, formula_previous_relation]
        calculator.valid?
      end

      it "adds an error to the second formula" do
        expect(formula_previous_relation.errors[:relation]).to include(I18n.t("activerecord.errors.models.formula.attributes.expression.relation_between_two_error"))
      end
    end

    context "when fomula already have relation" do
      before do
        calculator.formulas = [formula_next_relation, formula_none_relation, formula_previous_relation]
        calculator.valid?
      end

      it "adds an error to the second formula" do
        expect(formula_previous_relation.errors[:relation]).to include(I18n.t("activerecord.errors.models.formula.attributes.expression.already_have_relation_error"))
      end
    end

    context "when all formulas have valid relations" do
      before do
        calculator.formulas = [formula_next_relation, formula_none_relation, formula_next_relation, formula_none_relation]
        calculator.valid?
      end

      it "does not add errors to the formulas" do
        expect(formula_next_relation.errors[:relation]).to be_empty
        expect(formula_none_relation.errors[:relation]).to be_empty
      end
    end
  end
end
