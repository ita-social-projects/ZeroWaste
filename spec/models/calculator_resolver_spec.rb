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

  describe '#result' do

    let(:value) { 'P1 + 2' }
    let(:parameters) { {p1: 2} }
    let(:calculation) { create(:calculation, value: value) }
    subject  { CalculatorResolver.result(parameters, calculation.value) }

    context 'when pass valid data' do
      it { is_expected.to eq 4 }
    end

    context 'when pass invalid value' do
      let(:value) { 'not_number' }
      it { is_expected.to be_nil }
    end

    context 'when pass empty hash' do
      let(:parameters) { {} }
      it { is_expected.to be_nil }
    end

    context 'when pass number instead hash' do
      let(:parameters) { 2 }
      it { is_expected.to be_nil }
    end

    context 'when pass upcase letter in hash ' do
      let(:parameters) { {P1: 2} }
      it { is_expected.to eq 4 }
    end

    context 'when pass value with `since` formula' do
      let(:from) { Date.new(2020,01,01) }
      let(:to) { Date.new(2021,01,31) }
      let(:value) { "SINCE(#{from}, #{to}, 'day')" }
      it { is_expected.to eq 396 }
    end

    context 'when pass value with `from_list` formula' do
      let(:get_params) { FromList.to_hash }
      let(:calculator) { build(:calculator) }
      let(:range1) do
        create(:range_field, from: 5, type: 'Calculation', label: 'label',
                             kind: 'form', calculator: calculator, to: 19, value: '56')
      end
      let(:ranges) { [range1] }
      let(:value) { "FROM_LIST(#{ranges})" }
      it {
        expect(get_params.call([range1])).to eq({ range1 => { range1.from..range1.to => range1.value } })
      }
    end
  end
end
