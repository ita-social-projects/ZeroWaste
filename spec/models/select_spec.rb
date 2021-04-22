# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Select, type: :model do
  subject { create(:select) }
  LOCALIZATION_PREFIX = 'activerecord.errors.models.select.attributes'
  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value)
        .with_message(I18n.t("#{LOCALIZATION_PREFIX}.value.blank"))
    }
    it {
      is_expected.to validate_length_of(:value).is_at_least(2)
                                               .with_message(I18n.t("#{LOCALIZATION_PREFIX}.value.too_short"))
    }
  end
end
