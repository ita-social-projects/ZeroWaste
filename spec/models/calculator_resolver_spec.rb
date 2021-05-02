# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculatorResolver, type: :model do
  subject { CalculatorResolver }
  let(:calculator) { build(:calculator) }
  let!(:calculation1) { create(:calculation, value: 'F1 * P2 / P5', type: 'Calculation', label: 'one', kind: 'result', calculator: calculator) }
  let!(:calculation2) { create(:calculation, value: 'P5', type: 'Calculation', label: 'two', kind: 'result', calculator: calculator) }
  let!(:calculation3) { create(:calculation, value: 'Value', type: 'Value', label: 'three', kind: 'result', calculator: calculator) }


  it { is_expected.to respond_to(:call) }
  it { expect(CalculatorResolver.call(calculator)).to be_kind_of(Hash) }

  describe "#call" do
    context "when type == 'Result'" do
      it { expect(CalculatorResolver.call(calculator)[calculation1]).to match_array(["f1", "p2", "p5"]) }
      it { expect(CalculatorResolver.call(calculator)[calculation2]).to match_array(["p5"]) }
    end

    context "when type == 'Value'" do
      it { expect(CalculatorResolver.call(calculator)[calculation3]).to match_array([]) }
    end
  end
end
