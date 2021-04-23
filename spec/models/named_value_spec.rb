# frozen_string_literal: true

require 'rails_helper'
LOCAL_PREFIX_NAMED_VALUE = 'activerecord.errors.models.named_value.attributes'

RSpec.describe NamedValue, type: :model do
  subject(:named_value) { create(:named_value) }
  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:name).with_message(I18n
        .t("#{LOCAL_PREFIX_NAMED_VALUE}.name.blank"))
    }
    it {
      is_expected.to validate_length_of(:name).is_at_least(2).with_message(I18n
        .t("#{LOCAL_PREFIX_NAMED_VALUE}.name.too_short"))
    }
  end
end
