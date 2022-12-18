# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  from          :integer
#  kind          :integer          not null
#  label         :string
#  name          :string
#  selector      :string           not null
#  to            :integer
#  type          :string           not null
#  unit          :integer          default("day")
#  uuid          :uuid             not null
#  value         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#  index_fields_on_uuid           (uuid) UNIQUE
#
require "rails_helper"

LOCAL_PREFIX_SELECT = "activerecord.errors.models.select.attributes"

# RSpec.describe Select, type: :model do
#   subject { create(:select) }
#   describe 'validations' do
#     it { is_expected.to be_valid }
#     it {
#       is_expected.to validate_presence_of(:value).with_message(I18n
#         .t("#{LOCAL_PREFIX_SELECT}.value.blank"))
#     }
#     it {
#       is_expected.to validate_length_of(:value).is_at_least(2).with_message(I18n
#         .t("#{LOCAL_PREFIX_SELECT}.value.too_short"))
#     }
#   end
# end
