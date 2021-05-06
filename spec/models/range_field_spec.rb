# frozen_string_literal: true

require 'rails_helper'
require 'functions/from_list'
LOCAL_PREFIX_RANGE_FIELD = 'activerecord.errors.models.range_field.attributes'

RSpec.describe RangeField, type: :model do
  subject { create(:range_field) }
  describe 'validations' do
    it {
      is_expected.to validate_numericality_of(:from)
        .only_integer
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.from.not_a_number"))
    }
    it {
      is_expected.to validate_numericality_of(:to)
        .only_integer
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.to.not_an_integer"))
    }
    it {
      is_expected.to validate_length_of(:value)
        .is_at_least(1)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.value.too_short"))
    }
    it {
      is_expected.to validate_presence_of(:from)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.from.blank"))
    }
    it {
      is_expected.to validate_presence_of(:to)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.to.blank"))
    }
    it {
      is_expected.to validate_presence_of(:value)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.value.blank"))
    }
    context 'when pass value with `from_list` formula' do
      subject { RangeField }
      let(:get_params) { FromList.to_hash }
      let(:calculator) { build(:calculator) }
      let(:range1) do
        create(:range_field, from: 5, type: 'Calculation', label: 'label',
                             kind: 'form', calculator: calculator, to: 19, value: '56')
      end
      let(:ranges) { [range1, range2, range3] }
      let(:value) { "FROM_LIST(#{ranges})" }
      it {
        expect(get_params.call([range1])).to eq({ range1 => { range1.from..range1.to => range1.value } })
      }
    end
  end
end
