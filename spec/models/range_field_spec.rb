# frozen_string_literal: true

require 'rails_helper'
require 'functions/from_list'
LOCAL_PREFIX_RANGE_FIELD = 'activerecord.errors.models.range_field.attributes'

RSpec.describe RangeField, type: :model do
  subject { create(:range_field) }
  describe 'validations' do
    it {
      is_expected.to validate_numericality_of(:from)
        .only_integer
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.from.not_a_number"))
    }
    it {
      is_expected.to validate_numericality_of(:to)
        .only_integer
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.to.not_an_integer"))
    }
    it {
      is_expected.to validate_length_of(:value)
        .is_at_least(1)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.value.too_short"))
    }
    it {
      is_expected.to validate_presence_of(:from)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.from.blank"))
    }
    it {
      is_expected.to validate_presence_of(:to)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.to.blank"))
    }
    it {
      is_expected.to validate_presence_of(:value)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.value.blank"))
    }
  end
end
