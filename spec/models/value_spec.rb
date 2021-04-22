# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Value, type: :model do
  subject { create(:value) }
  LOCALIZATION_PREFIX = 'activerecord.errors.models.value.attributes'
  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value)
        .with_message(I18n.t("#{LOCALIZATION_PREFIX}.value.blank"))
    }
    it { is_expected.to allow_value('Value').for(:value) }
    it {
      is_expected.to validate_length_of(:value).is_at_least(1)
                                               .with_message(I18n.t("#{LOCALIZATION_PREFIX}.value.too_short"))
    }
    it {
      is_expected.not_to allow_value('.*+/+/').for(:value)
                                              .with_message(I18n.t("#{LOCALIZATION_PREFIX}.value.invalid"))
    }
  end
end
