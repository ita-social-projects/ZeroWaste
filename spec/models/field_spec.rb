# frozen_string_literal: true

require 'rails_helper'
LOCAL_PREFIX_FIELD = 'activerecord.errors.models.field.attributes'

RSpec.describe Field, type: :model do
  subject { create(:field) }

  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:type).with_message(I18n
        .t("#{LOCAL_PREFIX_FIELD}.type.blank"))
    }
    it {
      is_expected.to validate_presence_of(:label).with_message(I18n
      .t("#{LOCAL_PREFIX_FIELD}.label.blank"))
    }
    it {
      is_expected.to validate_presence_of(:kind).with_message(I18n
      .t("#{LOCAL_PREFIX_FIELD}.kind.blank"))
    }
    it {
      is_expected.to define_enum_for(:kind)
        .with_values(%i[form parameter result])
    }
    it {
      is_expected.to define_enum_for(:unit)
        .with_values(%i[day week month year date times money items])
    }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:calculator) }
  end

  describe '#set_selector' do
    let(:calculator) { create(:calculator) }
    let(:field) { build(:field, label: 'new', kind: 0, calculator: calculator) }

    context 'when there is no form fields in a database' do
      it 'generates selector with one letter and a number' do
        expect { field.save }.to change { field.selector }.from(nil).to('F1')
      end
    end
    context 'when there are more forms fields in a database' do
      before(:each) do
        create(:field, label: 'new', kind: 0, calculator: calculator)
      end
      it 'generates selector with one letter and an increased number' do
        expect { field.save }.to change { field.selector }.from(nil).to('F2')
      end
    end
  end
end
