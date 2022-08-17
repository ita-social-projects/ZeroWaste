# frozen_string_literal: true

require "rails_helper"
LOCAL_PREFIX_PRODUCT_PRICE = "activerecord.errors.models.product_price.attributes"

RSpec.describe ProductPrice, type: :model do
  subject { build(:product_price) }
  describe "validations" do
    describe "price" do
      it {
        should validate_presence_of(:price)
      }
      it {
        expect(subject.price).to be_a(Float)
      }
    end
    describe "category" do
      it {
        should validate_presence_of(:category)
      }
      it {
        should validate_inclusion_of(:category).in?([0, 1, 2])
      }
      describe "enum_names" do
        it {
          subject.category = 0
          expect(subject.category).to eq("LOW")
        }
        it {
          subject.category = 1
          expect(subject.category).to eq("MEDIUM")
        }
        it {
          subject.category = 2
          expect(subject.category).to eq("HIGH")
        }
      end
    end
  end
end
