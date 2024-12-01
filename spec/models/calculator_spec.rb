# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  color      :string           default("#000000")
#  en_name    :string           default(""), not null
#  slug       :string
#  uk_name    :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_calculators_on_slug  (slug) UNIQUE
#
require "rails_helper"

RSpec.describe Calculator, type: :model do
  let(:local_prefix_calculator) { "activerecord.errors.models.calculator.attributes" }

  subject { build(:calculator) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:en_name) }
    it { is_expected.to validate_length_of(:en_name).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:uk_name) }
    it { is_expected.to validate_length_of(:uk_name).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_uniqueness_of(:slug) }
  end

  describe "associations" do
    it { is_expected.to have_many(:fields).dependent(:destroy) }
    it { is_expected.to have_many(:formulas).dependent(:destroy) }
  end
end
