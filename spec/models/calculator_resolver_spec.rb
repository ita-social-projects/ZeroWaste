# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculatorResolver, type: :model do
  subject { described_class }
  let(:calculator) { build(:calculator) }
  let!(:calculation) { create(:calculation, value: 'P1 * P2 / P3', type: 'Calculation', label: 'one', kind: 'result', calculator: calculator) }
  let!(:value1) { create(:value, value: 'Value', type: 'Value', label: 'two', kind: 'result', calculator: calculator) }
  let!(:value2) { create(:value, value: 'Value', type: 'Value', label: 'three', kind: 'parameter', calculator: calculator) }
  let!(:value3) { create(:value, value: 'Value', type: 'Value', label: 'four', kind: 'parameter', calculator: calculator) }
  let!(:value4) { create(:value, value: 'Value', type: 'Value', label: 'five', kind: 'parameter', calculator: calculator) }

  describe "#call" do
    it { expect(CalculatorResolver.call(calculator)).to be_kind_of(Hash) }

    context "when 'field' is 'Calculation'" do
      it { expect(CalculatorResolver.call(calculator)[calculation]).to match_array([value2, value3, value4]) }
    end

    context "when 'field' is not 'Calculation'" do
      it { expect(CalculatorResolver.call(calculator)[value1]).to be_empty }
    end
  end
end
