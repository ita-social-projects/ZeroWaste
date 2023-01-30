# frozen_string_literal: true

require "rails_helper"

RSpec.describe CategoryCategoryable, type: :model do
  describe "validations" do
    let(:budgetary_category) { create(:category, :budgetary) }
    let(:medium_category) { create(:category, :medium) }
    let(:product_diaper) { build(:product, :diaper) }
    let(:product_napkin) { build(:product, :napkin) }
    # let(:resource) { build(:resource) }

    context "when a product(diaper) has one category" do
      it "returns valid product" do
        product_diaper.categories = [budgetary_category]

        expect(product_diaper.save).to eq true
      end
    end

    context "when a product(diaper) can have many different categories" do
      it "returns valid product" do
        product_diaper.categories = [budgetary_category, medium_category]

        expect(product_diaper.save).to eq true
      end
    end

    context "when a product(napkin) can have the same categories as a product(diaper)" do
      it "returns valid product" do
        product_diaper.categories = [budgetary_category, medium_category]
        product_napkin.categories = [budgetary_category, medium_category]

        expect(product_diaper.save).to eq true
        expect(product_napkin.save).to eq true
      end
    end

    skip "is skipped" do
      context "when a resource model can have the same categories as a product model" do
        it "returns valid product" do
          product_diaper.categories = [budgetary_category, medium_category]
          resource.categories       = [budgetary_category, medium_category]

          expect(product_diaper.save).to eq true
          expect(resource.save).to eq true
        end
      end
    end

    context "when a product(diaper) cannot have two identical categories" do
      it "returns invalid product" do
        product_diaper.categories = [budgetary_category, budgetary_category]

        expect do
          product_diaper.save!
        end.to raise_error(ActiveRecord::RecordInvalid,
                           "Validation failed: Category has already been taken")
      end
    end
  end
end
