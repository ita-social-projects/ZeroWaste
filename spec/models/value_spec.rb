# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  en_label      :string           default(""), not null
#  kind          :string           not null
#  uk_label      :string           default(""), not null
#  unit          :integer          default("day")
#  var_name      :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#
# Foreign Keys
#
#  fk_rails_...  (calculator_id => calculators.id)
#
require "rails_helper"

RSpec.describe Value, type: :model do
  let(:local_prefix_value) { "activerecord.errors.models.value.attributes" }

  subject { create(:value) }

  describe "validations" do
    it { is_expected.to be_valid }
    it {
      is_expected.to validate_presence_of(:value).with_message(I18n
        .t("#{local_prefix_value}.value.too_short"))
    }
    it { is_expected.to allow_value("Value").for(:value) }
    it {
      is_expected.to validate_length_of(:value).is_at_least(1).with_message(I18n
        .t("#{local_prefix_value}.value.too_short"))
    }
    it {
      is_expected.not_to allow_value(".*+/+/").for(:value).with_message(I18n
        .t("#{local_prefix_value}.value.invalid"))
    }
  end
end
