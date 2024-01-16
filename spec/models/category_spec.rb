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

LOCAL_PREFIX_CATEGORY = "activerecord.errors.models.category.attributes"

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

  context "validates the name format" do
    let(:category) { build(:category) }

    it "with valid name" do
      category.name = "Hedgehog і єнот з'їли 2 аґруси"

      expect(category).to be_valid
    end

    it "with invalid name" do
      ["#", "!", "@", "$", "%", "^", "&", "*", "(", ")", "?", "\"", "_"].each do |sym|
        category.name = "Invalid Name #{sym}"

        expect(category).to_not be_valid
        expect(category.errors.messages[:name]).to include(I18n.t("#{LOCAL_PREFIX_CATEGORY}.name.invalid"))
      end
    end
  end
end
