# frozen_string_literal: true

require 'rails_helper'
LOCAL_PREFIX_SELECT = 'activerecord.errors.models.select.attributes'

RSpec.describe Select, type: :model do
  subject { create(:select) }
  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value).with_message(I18n
        .t("#{LOCAL_PREFIX_SELECT}.value.blank"))
    }
    it {
      is_expected.to validate_length_of(:value).is_at_least(2).with_message(I18n
        .t("#{LOCAL_PREFIX_SELECT}.value.too_short"))
    }
  end
end
