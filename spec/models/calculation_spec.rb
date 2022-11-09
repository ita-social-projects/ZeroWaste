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
LOCAL_PREFIX_CALCULATION = 'activerecord.errors.models.calculation.attributes'

RSpec.describe Calculation, type: :model do
  subject(:calculation) { create(:calculation) }

  describe 'validations' do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value).with_message(I18n
      .t("#{LOCAL_PREFIX_CALCULATION}.value.too_short"))
    }
    it {
      is_expected.to validate_length_of(:value).is_at_least(2).with_message(I18n
      .t("#{LOCAL_PREFIX_CALCULATION}.value.too_short"))
    }
  end
end
