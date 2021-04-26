# frozen_string_literal: true

require 'rails_helper'
LOCAL_PREFIX_CALCULATION = 'activerecord.errors.models.calculation.attributes'

RSpec.describe Calculation, type: :model do
  subject(:calculation) { create(:calculation) }

  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value).with_message(I18n
      .t("#{LOCAL_PREFIX_CALCULATION}.value.blank"))
    }
    it {
      is_expected.to validate_length_of(:value).is_at_least(2).with_message(I18n
      .t("#{LOCAL_PREFIX_CALCULATION}.value.too_short"))
    }
  end

  describe '#result' do
    it {  }
    it {  }
    it {  }
  end
end
