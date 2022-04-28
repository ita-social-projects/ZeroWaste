# frozen_string_literal: true

require 'rails_helper'
LOCAL_PREFIX_NAMED_VALUE = 'activerecord.errors.models.named_value.attributes'

RSpec.describe NamedValue, type: :model do
  subject(:named_value) { create(:named_value) }
  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:name).with_message(I18n
        .t("#{LOCAL_PREFIX_NAMED_VALUE}.name.too_short"))
    }
    it {
      is_expected.to validate_length_of(:name).is_at_least(2).with_message(I18n
        .t("#{LOCAL_PREFIX_NAMED_VALUE}.name.too_short"))
    }
    it {
      is_expected.to validate_numericality_of(:from)
                       .only_integer
                       .with_message(I18n.t("#{LOCAL_PREFIX_NAMED_VALUE}.from.not_a_number"))
    }
    it {
      is_expected.to validate_numericality_of(:to)
                       .only_integer
                       .with_message(I18n.t("#{LOCAL_PREFIX_NAMED_VALUE}.to.not_an_integer"))
    }
    it {
      is_expected.to validate_presence_of(:from)
                       .with_message(I18n.t("#{LOCAL_PREFIX_NAMED_VALUE}.from.not_an_integer"))
    }
    it {
      is_expected.to validate_presence_of(:to)
                       .with_message(I18n.t("#{LOCAL_PREFIX_NAMED_VALUE}.to.not_an_integer"))
    }
  end
end
