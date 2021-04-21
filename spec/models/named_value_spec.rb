# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NamedValue, type: :model do
  subject(:named_value) { create(:named_value) }
  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name).with_message(I18n.t('activerecord.errors.models.named_value.attributes.name.blank')) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).with_message(I18n.t('activerecord.errors.models.named_value.attributes.name.too_short')) }
  end
end
