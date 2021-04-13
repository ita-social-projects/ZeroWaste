require 'rails_helper'

RSpec.describe Field, type: :model do
  subject(:field) { build(:field) } 

  describe "validations" do
    it { should validate_presence_of(:uuid) }
    it { should validate_presence_of(:selector) }
    it { should validate_presence_of(:type) }
    it { should define_enum_for(:kind).
      with_values([:form, :parameter, :result]) }
  end
  describe "associations" do
    it { should belong_to(:calculator) }
  end
end
