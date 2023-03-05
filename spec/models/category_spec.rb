# == Schema Information
#
# Table name: categories
#  name                   :string
#  priority               :integer          not null      default 0
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe Category, type: :model do
  subject { build(:category) }

  describe "associations" do
    it { is_expected.to have_many(:category_categoryables).dependent(:restrict_with_exception) }

    it { is_expected.to have_many(:categoryables).through(:category_categoryables).source(:category) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_numericality_of(:priority).is_greater_than_or_equal_to(0) }
  end
end
