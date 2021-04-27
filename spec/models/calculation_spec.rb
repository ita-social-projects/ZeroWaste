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
    it 'Should be valid' do
      calculation = Calculation.new(value: 'P1 + 2')
      expect(calculation.result({P1: 2})).to eq 4
    end

    it 'Should return nil (invalid value)' do
      calculation = Calculation.new()
      expect(calculation.result({P1: 2})).to eq nil
    end

    it 'Should return nil (invalid parameters)' do
      calculation = Calculation.new(value: 'P1 + 2')
      expect(calculation.result({})).to eq nil
    end

    it 'Should return nil (invalid value and parameters)' do
      calculation = Calculation.new()
      expect(calculation.result({})).to eq nil
    end

    it 'Should return nil (pass number instead hash)' do
      calculation = Calculation.new(value: 'P1 + 2')
      expect(calculation.result(2)).to eq nil
    end
  end
end
