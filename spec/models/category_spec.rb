# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  en_name    :string
#  preferable :boolean          default(FALSE), not null
#  price      :decimal(10, 2)   default(0.0), not null
#  priority   :integer          default(0), not null
#  uk_name    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :bigint           not null
#
# Indexes
#
#  index_categories_on_field_id  (field_id)
#
# Foreign Keys
#
#  fk_rails_...  (field_id => fields.id)
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
    it { is_expected.to validate_presence_of(:uk_name) }
    it { is_expected.to validate_length_of(:uk_name).is_at_least(3).is_at_most(30) }
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
