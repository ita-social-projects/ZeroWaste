# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  priority   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe "associations" do
    it { is_expected.to have_many(:category_categoryables).dependent(:restrict_with_exception) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(30) }
    it { is_expected.to validate_numericality_of(:priority).is_greater_than_or_equal_to(0) }
  end

  context "checking the amount of errors" do
    let(:category) { build(:category, name: "") }

    it "returns only one error message when field is blank" do
      category.valid?
      expect(category.errors.full_messages_for(:name).length).to eq 1
      expect(category.errors.full_messages_for(:name)).to include("Name can't be blank")
    end
  end
end
