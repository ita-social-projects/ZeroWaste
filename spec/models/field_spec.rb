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
    let(:calculator) { build(:calculator, name: "new") }
    let(:field) { build(:field, calculator: calculator, type: "form", label: "new", kind: 0) }
    it "generates selector with one letter and a number" do
      expect { field.save }.to change { field.selector }.from(nil).to('F1')
    end
  end
end
