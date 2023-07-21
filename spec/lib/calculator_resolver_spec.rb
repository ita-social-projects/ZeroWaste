# frozen_string_literal: true

require "rails_helper"

RSpec.describe CalculatorResolver, type: :lib do
  subject { described_class }

  let(:calculator) { build(:calculator) }
  let!(:calculation_r1) { create(:calculation, value: "P1 * P2 / P3", type: "Calculation", selector: "R1", label: "one", kind: "result", calculator: calculator) }
  let!(:calculation_r2) { create(:calculation, value: "10 * P4", type: "Calculation", selector: "R2", label: "one", kind: "result", calculator: calculator) }
  let!(:calculation_p4) { create(:value, value: "P1 * P5", type: "Calculation", selector: "P4", label: "four", kind: "parameter", calculator: calculator) }
  let!(:calculation_p5) { create(:value, value: "P2 * P6", type: "Calculation", selector: "P5", label: "four", kind: "parameter", calculator: calculator) }
  let!(:value_r3) { create(:value, value: "Value", type: "Value", selector: "R3", label: "two", kind: "result", calculator: calculator) }
  let!(:value_p1) { create(:value, value: "Value", type: "Value", selector: "P1", label: "three", kind: "parameter", calculator: calculator) }
  let!(:value_p2) { create(:value, value: "Value", type: "Value", selector: "P2", label: "four", kind: "parameter", calculator: calculator) }
  let!(:value_p3) { create(:value, value: "Value", type: "Value", selector: "P3", label: "five", kind: "parameter", calculator: calculator) }
  let!(:value_p6) { create(:value, value: "Value", type: "Value", selector: "P6", label: "six", kind: "parameter", calculator: calculator) }

  describe "#call" do
    it { expect(CalculatorResolver.call(calculator)).to be_kind_of(Hash) }

    context "when 'field' is 'Calculation'" do
      it { expect(CalculatorResolver.call(calculator)[calculation_r1]).to match_array([value_p1, value_p2, value_p3]) }
    end

    context "when 'field' is not 'Calculation'" do
      it { expect(CalculatorResolver.call(calculator)[value_r3]).to be_empty }
    end

    context "when 'Calculation' contains deep-level nested dependecies" do
      it { expect(CalculatorResolver.call(calculator)[calculation_r2]).to match_array([value_p1, value_p2, value_p6]) }
    end
  end
end
