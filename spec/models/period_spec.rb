require "rails_helper"

RSpec.describe Period, type: :model do
  subject { build(:period) }

  describe "associations" do
    it { is_expected.to belong_to(:category) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:period_start).only_integer.is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:period_end).only_integer }
    it { is_expected.to validate_numericality_of(:usage_amount).only_integer.is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  describe "custom validation logic" do
    it "is invalid if period_end is less than or equal to period_start" do
      period = build(:period, period_start: 10, period_end: 5)
      expect(period).not_to be_valid
      expect(period.errors[:period_end]).to include("must be greater than 10")
    end
  end
end
