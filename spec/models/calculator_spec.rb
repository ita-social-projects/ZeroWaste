# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calculator, type: :model do
  subject { build(:calculator) }
  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:name).with_message(I18n.t('activerecord.errors.models.calculator.attributes.name.blank'))
    }
    it {
      is_expected.to validate_length_of(:name).is_at_least(2).with_message(I18n.t('activerecord.errors.models.calculator.attributes.name.too_short'))
    }
    it {
      is_expected.not_to allow_value('Hh34').for(:name).with_message(I18n.t('activerecord.errors.models.calculator.attributes.name.invalid'))
    }
  end
end
