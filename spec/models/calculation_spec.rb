# frozen_string_literal: true

require 'rails_helper'
LOCAL_PREFIX_CALCULATION = 'activerecord.errors.models.calculation.attributes'

RSpec.describe Calculation, type: :model do
  subject(:calculation) { create(:calculation) }

  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value).with_message(I18n
      .t("#{LOCAL_PREFIX_CALCULATION}.value.blank"))
    }
    it {
      is_expected.to validate_length_of(:value).is_at_least(2).with_message(I18n
      .t("#{LOCAL_PREFIX_CALCULATION}.value.too_short"))
    }
  end

  describe '#result' do

    let(:value) { 'P1 + 2' }
    let(:parameters) { {p1: 2} }
    let(:calculation) { create(:calculation, value: value) }
    subject  { calculation.result(parameters) }

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

    context 'when pass `since` value and `from`, `to`, `unit` parameters' do
      let(:value) { 'since' }
      let(:from) { Date.new(2020,01,01) }
      let(:to) { Date.new(2021,01,31) }
      let(:parameters) { {from: from, to: to, unit: 'day'} }
      it { is_expected.to eq 396 }
    end
  end
end
