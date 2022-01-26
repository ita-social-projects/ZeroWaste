# frozen_string_literal: true

require 'rails_helper'
LOCAL_PREFIX_CALCULATOR = 'activerecord.errors.models.calculator.attributes'

RSpec.describe Calculator, type: :model do
  subject { build(:calculator) }
  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:name).with_message(I18n
        .t("#{LOCAL_PREFIX_CALCULATOR}.name.too_short"))
    }
    it {
      is_expected.to validate_length_of(:name).is_at_least(2).with_message(I18n
        .t("#{LOCAL_PREFIX_CALCULATOR}.name.too_short"))
    }
    it {
      is_expected.not_to allow_value('Hh@').for(:name).with_message(I18n
        .t("#{LOCAL_PREFIX_CALCULATOR}.name.invalid"))
    }
    it {
      is_expected.to validate_uniqueness_of(:name)
    }
  end

  describe 'scope' do
    context 'finds instances by slug and name' do
      let!(:calc) { create(:calculator, slug: 'calc') }
      let!(:calc2) { create(:calculator, slug: 'diapers', name: 'Calculator') }

      it 'finds two instances by slug or name' do
        expect(Calculator.by_name_and_slug("calc").to_a).to include(calc, calc2)
      end

      it 'returns all instances when search params are empty' do
        expect(Calculator.by_name_and_slug("    ").to_a).to include(calc, calc2)
      end

      it 'does not find any instances' do
        expect(Calculator.by_name_and_slug("qwerty").to_a).to eq []
      end
    end
    
  end
end
