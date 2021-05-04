# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculatorResolver, type: :model do
  subject { CalculatorResolver }
  let(:calculator) { build(:calculator) }
  let!(:calculation) { create(:calculation, value: 'P1 * P2 / P3', type: 'Calculation', label: 'one', kind: 'result', calculator: calculator) }
  let!(:value1) { create(:value, value: 'Value', type: 'Value', label: 'two', kind: 'result', calculator: calculator) }
  let!(:value2) { create(:value, value: 'Value', type: 'Value', label: 'three', kind: 'parameter', calculator: calculator) }
  let!(:value3) { create(:value, value: 'Value', type: 'Value', label: 'four', kind: 'parameter', calculator: calculator) }
  let!(:value4) { create(:value, value: 'Value', type: 'Value', label: 'five', kind: 'parameter', calculator: calculator) }

  it { is_expected.to respond_to(:call) }
  it { expect(CalculatorResolver.call(calculator)).to be_kind_of(Hash) }

  describe "#call" do
    context "when type == 'Result'" do
      it { expect(CalculatorResolver.call(calculator)[calculation]).to match_array([value2, value3, value4]) }
    end

    context "when type == 'Value'" do
      it { expect(CalculatorResolver.call(calculator)[value1]).to match_array([]) }
    end
  end
end
