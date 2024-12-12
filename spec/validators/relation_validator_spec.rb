require "rails_helper"

RSpec.describe RelationValidator do
  let(:calculator) { build(:calculator) }

  describe "validations" do
    let(:formula_1) { build(:formula, relation: "previous") }
    let(:formula_2) { build(:formula, relation: "next") }
    let(:formula_3) { build(:formula, relation: nil) }

    context "when the first formula has a relation of 'Previous'" do
      before do
        calculator.formulas = [formula_1]
        calculator.valid?
      end

      it "adds an error to the first formula" do
        expect(formula_1.errors[:relation]).to include("The first formula cannot have a relation of 'Previous' because there is no previous formula.")
      end
    end

    context "when the last formula has a relation of 'Next'" do
      before do
        calculator.formulas = [formula_2]
        calculator.valid?
      end

      it "adds an error to the last formula" do
        expect(formula_2.errors[:relation]).to include("The last formula cannot have a relation of 'Next' because there is no next formula.")
      end
    end

    context "when formulas have consecutive relations 'Next' and 'Previous'" do
      before do
        calculator.formulas = [formula_2, formula_1]
        calculator.valid?
      end

      it "adds an error to the second formula" do
        expect(formula_1.errors[:relation]).to include("cannot have the same relation as the previous formula.")
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
