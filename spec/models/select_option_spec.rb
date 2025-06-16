require 'rails_helper'

RSpec.describe SelectOption, type: :model do
  subject { build(:select_option) }

  describe "associations" do
    it { is_expected.to belong_to(:field) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:key) }
    it { is_expected.to validate_length_of(:key).is_at_least(1).is_at_most(50) }

    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_numericality_of(:value) }
  end

  context "when key is blank" do
    let(:select_option) { build(:select_option, key: "") }

    it "returns one error message for blank key" do
      select_option.valid?
      expect(select_option.errors.full_messages_for(:key).length).to eq 1
      expect(select_option.errors.full_messages_for(:key)).to include("Key can't be blank")
    end
  end

  context "when value is not a number" do
    let(:select_option) { build(:select_option, value: "abc") }

    it "is not valid" do
      expect(select_option).not_to be_valid
      expect(select_option.errors[:value]).to include("is not a number")
    end
  end
end
