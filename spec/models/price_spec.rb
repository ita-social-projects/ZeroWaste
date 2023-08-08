# == Schema Information
#
# Table name: prices
#
#  id             :bigint           not null, primary key
#  priceable_type :string
#  sum            :decimal(8, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :integer
#  priceable_id   :bigint
#
# Indexes
#
#  index_prices_on_category_id                                      (category_id)
#  index_prices_on_category_id_and_priceable_id_and_priceable_type  (category_id,priceable_id,priceable_type) UNIQUE
#  index_prices_on_priceable                                        (priceable_type,priceable_id)
#
require "rails_helper"

RSpec.describe Price, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:priceable) }

    it { is_expected.to belong_to(:category).optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:sum) }

    subject { FactoryBot.build(:price) }

    it { is_expected.to validate_uniqueness_of(:category_id).scoped_to([:priceable_id, :priceable_type]) }
  end
end
