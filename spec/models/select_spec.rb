# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  en_label      :string           default(""), not null
#  kind          :string           not null
#  uk_label      :string           default(""), not null
#  unit          :integer          default("day")
#  var_name      :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#
# Foreign Keys
#
#  fk_rails_...  (calculator_id => calculators.id)
#
require "rails_helper"

RSpec.describe Select, type: :model do
  describe "validations" do
    context "with a valid label length of 2 characters" do
      subject { build(:select, label: "ab") }

      it { is_expected.to be_valid }
    end

    context "with a label of less than 2 characters" do
      subject(:select) { build(:select, label: "a") }

      it "is not valid" do
        select.valid?

        expect(select.errors[:label]).to include("is too short (minimum is 2 characters)")
      end
    end
  end
end
