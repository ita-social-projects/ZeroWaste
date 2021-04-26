# frozen_string_literal: true

require 'rails_helper'
LOCAL_PREFIX_CALCULATOR = 'activerecord.errors.models.calculator.attributes'

RSpec.describe Calculator, type: :model do
  subject { build(:calculator) }
  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:name).with_message(I18n
        .t("#{LOCAL_PREFIX_CALCULATOR}.name.blank"))
    }
    it {
      is_expected.to validate_length_of(:name).is_at_least(2).with_message(I18n
        .t("#{LOCAL_PREFIX_CALCULATOR}.name.too_short"))
    }
    it {
      is_expected.not_to allow_value('Hh@').for(:name).with_message(I18n
        .t("#{LOCAL_PREFIX_CALCULATOR}.name.invalid"))
    }
  end
end
