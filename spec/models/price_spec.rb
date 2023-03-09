# == Schema Information
#
# Table name: price
#  sum                    :decimal
#  priceable_type         :string
#  priceable_id           :bigint
#  category_id            :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe Price, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:priceable) }

    it { is_expected.to belong_to(:category).optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:sum) }

    it { is_expected.to validate_uniqueness_of(:category_id).scoped_to([:priceable_id, :priceable_type]) }
  end
end
