# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Field, type: :model do
  subject(:field) { build(:field) }

  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:type).with_message(I18n.t('activerecord.errors.models.field.attributes.type.blank'))
    }
    it {
      is_expected.to validate_presence_of(:label).with_message(I18n.t('activerecord.errors.models.field.attributes.label.blank'))
    }
    it {
      is_expected.to validate_presence_of(:kind).with_message(I18n.t('activerecord.errors.models.field.attributes.kind.blank'))
    }
    it {
      is_expected.to define_enum_for(:kind)
        .with_values(%i[form parameter result])
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
