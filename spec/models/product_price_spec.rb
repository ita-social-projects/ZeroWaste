# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductPrice, type: :model do
  describe "validations" do
    context "price" do
      it {
        is_expected.to validate_presence_of(:price)
      }
    end
    context "category" do
      it {
        is_expected.to validate_presence_of(:category)
      }
      it {
        should validate_inclusion_of(:category).in?([0, 1, 2])
      }
    end
  end
  describe "category names" do
    subject { create(:product_price, category: category) }
    context "when category 0" do
      let(:category) { 0 }
      it {
        expect(subject.category).to eq("LOW")
      }
    end
    context "when category 1" do
      let(:category) { 1 }
      it {
        expect(subject.category).to eq("MEDIUM")
      }
    end
    context "when category 2" do
      let(:category) { 2 }
      it {
        expect(subject.category).to eq("HIGH")
      }
    end
  end
  describe "correct datatype" do
    subject { create(:product_price) }
    context "when price is a float" do
      it {
        expect(subject.price).to be_a(Float)
      }
    end
  end
end
