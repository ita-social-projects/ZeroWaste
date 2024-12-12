require "rails_helper"

RSpec.describe RelationValidator do
  let(:calculator) { build(:calculator) }

  describe "validations" do
    let(:formula_1) { build(:formula, relation: "previous") }
    let(:formula_2) { build(:formula, relation: "next") }
    let(:formula_3) { build(:formula, relation: nil) }

    context "when the first formula has a relation of previous" do
      before do
        calculator.formulas = [formula_1]
        calculator.valid?
      end

      it "adds an error to the first formula" do
        expect(formula_1.errors[:relation]).to include(I18n.t("activerecord.errors.models.formula.attributes.expression.first_relation_error"))
      end
    end

    context "when the last formula has a relation of next" do
      before do
        calculator.formulas = [formula_3, formula_2]
        calculator.valid?
      end

      it "adds an error to the last formula" do
        expect(formula_2.errors[:relation]).to include(I18n.t("activerecord.errors.models.formula.attributes.expression.last_relation_error"))
      end
    end

    context "when formulas have consecutive relations 'next' and 'previous'" do
      before do
        calculator.formulas = [formula_2, formula_1]
        calculator.valid?
      end

      it "adds an error to the second formula" do
        expect(formula_1.errors[:relation]).to include(I18n.t("activerecord.errors.models.formula.attributes.expression.relation_between_two_error"))
      end
    end

    context "when all formulas have valid relations" do
      before do
        calculator.formulas = [formula_3, formula_1]
        calculator.valid?
      end

      it "does not add errors to the formulas" do
        expect(formula_1.errors[:relation]).to be_empty
        expect(formula_3.errors[:relation]).to be_empty
      end
    end
  end
end
