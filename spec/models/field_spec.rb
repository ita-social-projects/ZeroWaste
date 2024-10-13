# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  from          :integer
#  kind          :integer          not null
#  label         :string
#  name          :string
#  selector      :string           not null
#  to            :integer
#  type          :string           not null
#  unit          :integer          default("day")
#  uuid          :uuid             not null
#  value         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#  index_fields_on_uuid           (uuid) UNIQUE
#
require "rails_helper"

RSpec.describe Field, type: :model do
  let(:local_prefix_field) { "activerecord.errors.models.field.attributes" }

  subject { create(:field) }

  describe "validations" do
    it {
      is_expected.to validate_presence_of(:type).with_message(I18n
        .t("#{local_prefix_field}.type.blank"))
    }
    it {
      is_expected.to validate_presence_of(:label).with_message(I18n
      .t("#{local_prefix_field}.label.blank"))
    }
    it {
      is_expected.to validate_presence_of(:kind).with_message(I18n
      .t("#{local_prefix_field}.kind.blank"))
    }
    it {
      is_expected.to define_enum_for(:kind)
        .with_values([:form, :parameter, :result])
    }
    it {
      is_expected.to define_enum_for(:unit)
        .with_values([:day, :week, :month, :year, :date, :times, :money, :items])
    }
  end

  describe "associations" do
    it { is_expected.to belong_to(:calculator) }
  end

  describe "#set_selector" do
    let(:calculator) { create(:calculator, :diaper_calculator) }
    let(:field) { build(:field, label: "new", kind: 0, calculator: calculator) }

    context "when there is no form fields in a database" do
      it "generates selector with one letter and a number" do
        expect { field.save }.to change { field.selector }.from(nil).to("F1")
      end
    end

    context "when there are more forms fields in a database" do
      before do
        create(:field, label: "new", kind: 0, calculator: calculator)
      end

      it "generates selector with one letter and an increased number" do
        expect { field.save }.to change { field.selector }.from(nil).to("F2")
      end
    end
  end
end
