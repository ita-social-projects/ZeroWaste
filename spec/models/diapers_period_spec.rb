# frozen_string_literal: true

# == Schema Information
#
# Table name: diapers_periods
#
#  category_id :bigint          null: false
#  price :decimal               precision: 8, scale: 2
#  period_start :integer        null: false
#  period_end :integer          null: false
#  usage_amount :integer        null: false
#  created_at :datetime         null: false
#  updated_at :datetime         null: false
#  index ["category_id"], name: "index_diapers_periods_on_category_id"

require "rails_helper"

RSpec.describe DiapersPeriod, type: :model do
  let(:diapers_period) { FactoryBot.build :diapers_period }

  describe "associations" do
    it { is_expected.to belong_to(:category) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

    it { is_expected.to validate_presence_of(:period_start) }
    it { is_expected.to validate_numericality_of(:period_start).is_greater_than_or_equal_to(1) }

    it { is_expected.to validate_presence_of(:period_end) }

    it "period end is greater than period start" do
      expect(diapers_period.period_end).to be > diapers_period.period_start
    end

    it "period end is less than 30" do
      expect(diapers_period.period_end).to be <= 30
    end

    it { is_expected.to validate_presence_of(:usage_amount) }
    it { is_expected.to validate_numericality_of(:usage_amount).is_greater_than_or_equal_to(0) }
  end
end
