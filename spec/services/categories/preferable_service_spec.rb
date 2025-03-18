# frozen_string_literal: true

require "rails_helper"

RSpec.describe Categories::PreferableService, type: :service do
  describe "#call" do
    let(:category) { create(:category, preferable: true) }
    let!(:other_category) { create(:category, preferable: false) }

    subject { described_class.new(category) }

    context "when category is preferable" do
      it "updates other categories to not preferable" do
        subject.call

        expect(category.reload.preferable?).to be(true)
        expect(other_category.reload.preferable?).to be(false)
      end
    end

    context "when category is not preferable" do
      let(:category) { create(:category, preferable: false) }

      it "does not update other categories" do
        expect { subject.call }.not_to change { other_category.reload.preferable? }
      end
    end
  end
end
