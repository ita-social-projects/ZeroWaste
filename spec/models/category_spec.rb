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
    it { is_expected.to validate_presence_of(:en_name) }
    it { is_expected.to validate_length_of(:en_name).is_at_least(3).is_at_most(30) }
    it { is_expected.to validate_uniqueness_of(:en_name).case_insensitive }
    it { is_expected.to validate_presence_of(:uk_name) }
    it { is_expected.to validate_length_of(:uk_name).is_at_least(3).is_at_most(30) }
    it { is_expected.to validate_uniqueness_of(:uk_name).case_insensitive }
    it { is_expected.to validate_numericality_of(:priority).is_greater_than_or_equal_to(0) }
  end

  context "checking the number of errors" do
    let(:category) { build(:category, en_name: "") }

    it "returns only one error message when field is blank" do
      category.valid?
      expect(category.errors.full_messages_for(:en_name).length).to eq 1
      expect(category.errors.full_messages_for(:en_name)).to include("Title in English can't be blank")
    end
  end
end
