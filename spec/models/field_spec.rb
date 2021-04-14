require 'rails_helper'

RSpec.describe Field, type: :model do
  subject(:field) { build(:field) } 

  describe "validations" do
    it { is_expected.to validate_presence_of(:uuid) }
    it { is_expected.to validate_presence_of(:selector) }
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to define_enum_for(:kind).
      with_values([:form, :parameter, :result]) }
  end
  describe "associations" do
    it { is_expected.to belong_to(:calculator) }
  end
end
