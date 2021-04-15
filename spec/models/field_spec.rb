require 'rails_helper'

RSpec.describe Field, type: :model do
  subject(:field) { build(:field) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:uuid) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to define_enum_for(:kind).
      with_values([:form, :parameter, :result]) }
  end
  describe "associations" do
    it { is_expected.to belong_to(:calculator) }
  end
  describe "#set_selector" do
    it do
      field.type = "form"
      expect(field.send(:set_selector)).to eq("F1")
    end
    it do
      field.type = "parameter"
      expect(field.send(:set_selector)).to eq("P1")
    end
    it do
      field.type = "result"
      expect(field.send(:set_selector)).to eq("R1")
    end
  end
end
