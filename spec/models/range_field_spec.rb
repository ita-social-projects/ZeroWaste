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

RSpec.describe RangeField, type: :model do
  let(:local_prefix_range_field) { "activerecord.errors.models.range_field.attributes" }

  subject { create(:range_field) }

  describe "validations" do
    it {
      is_expected.to validate_numericality_of(:from)
        .only_integer
        .with_message(I18n.t("#{local_prefix_range_field}.from.not_a_number"))
    }
    it {
      is_expected.to validate_numericality_of(:to)
        .only_integer
        .with_message(I18n.t("#{local_prefix_range_field}.to.not_an_integer"))
    }
    it {
      is_expected.to validate_length_of(:value)
        .is_at_least(1)
        .with_message(I18n.t("#{local_prefix_range_field}.value.too_short"))
    }
    it {
      is_expected.to validate_presence_of(:from)
        .with_message(I18n.t("#{local_prefix_range_field}.from.not_an_integer"))
    }
    it {
      is_expected.to validate_presence_of(:to)
        .with_message(I18n.t("#{local_prefix_range_field}.to.not_an_integer"))
    }
    it {
      is_expected.to validate_presence_of(:value)
        .with_message(I18n.t("#{local_prefix_range_field}.value.too_short"))
    }
  end
end
