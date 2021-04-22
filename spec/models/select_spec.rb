# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Select, type: :model do
  subject { create(:select) }
  let(:localization_prefix) do
    'activerecord.errors.models.select.attributes.value'
  end
  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value)
        .with_message(I18n.t("#{localization_prefix}.blank"))
    }
    it {
      is_expected.to validate_length_of(:value).is_at_least(2)
        .with_message(I18n.t("#{localization_prefix}.too_short"))
    }
  end
end
