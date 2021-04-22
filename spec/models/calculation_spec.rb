# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calculation, type: :model do
  subject(:calculation) { create(:calculation) }

  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value).with_message(I18n.t('activerecord.errors.models.calculation.attributes.value.blank'))
    }
    it {
      is_expected.to validate_length_of(:value).is_at_least(2).with_message(I18n.t('activerecord.errors.models.calculation.attributes.value.too_short'))
    }
  end
end
