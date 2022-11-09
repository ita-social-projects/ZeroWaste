# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  uuid          :uuid             not null
#  calculator_id :bigint           not null
#  selector      :string           not null
#  type          :string           not null
#  label         :string
#  name          :string
#  value         :string
#  from          :integer
#  to            :integer
#  kind          :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  unit          :integer          default("day")
#
require 'rails_helper'
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
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.from.not_an_integer"))
    }
    it {
      is_expected.to validate_presence_of(:to)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.to.not_an_integer"))
    }
    it {
      is_expected.to validate_presence_of(:value)
        .with_message(I18n.t("#{LOCAL_PREFIX_RANGE_FIELD}.value.too_short"))
    }
  end
end
