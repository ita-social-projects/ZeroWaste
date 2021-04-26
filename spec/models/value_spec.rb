# frozen_string_literal: true

require 'rails_helper'
LOCAL_PREFIX_VALUE = 'activerecord.errors.models.value.attributes'

RSpec.describe Value, type: :model do
  subject { create(:value) }
  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value).with_message(I18n
        .t("#{LOCAL_PREFIX_VALUE}.value.blank"))
    }
    it { is_expected.to allow_value('Value').for(:value) }
    it {
      is_expected.to validate_length_of(:value).is_at_least(1).with_message(I18n
        .t("#{LOCAL_PREFIX_VALUE}.value.too_short"))
    }
    it {
      is_expected.not_to allow_value('.*+/+/').for(:value).with_message(I18n
        .t("#{LOCAL_PREFIX_VALUE}.value.invalid"))
    }
  end
end
