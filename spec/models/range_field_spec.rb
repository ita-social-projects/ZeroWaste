# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RangeField, type: :model do
  subject { create(:range_field) }
  let(:localization_prefix) do
    'activerecord.errors.models.range_field.attributes'
  end
  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:from)
        .with_message(I18n.t("#{localization_prefix}.from.blank"))
    }
    it {
      is_expected.to validate_presence_of(:to)
        .with_message(I18n.t("#{localization_prefix}.to.blank"))
    }
    it {
      is_expected.to validate_presence_of(:value)
        .with_message(I18n.t("#{localization_prefix}.value.blank"))
    }
    it {
      is_expected.to validate_numericality_of(:from)
        .only_integer
        .with_message(I18n.t("#{localization_prefix}.from.not_a_number"))
    }
    it {
      is_expected.to validate_numericality_of(:to)
        .only_integer
        .with_message(I18n.t("#{localization_prefix}.to.not_an_integer"))
    }
    it {
      is_expected.to validate_length_of(:value)
        .is_at_least(1)
        .with_message(I18n.t("#{localization_prefix}.value.too_short"))
    }
  end
end
