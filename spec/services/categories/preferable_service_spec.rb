require "rails_helper"

RSpec.describe Categories::PreferableService do
  describe "#call" do
    let!(:become_preferable_category) { create(:category, :medium) }
    let!(:category) { create(:category, name: "category") }
    let!(:current_preferable_category) { create(:category, name: "current preferable category", preferable: "1") }
    let!(:service) { described_class.new(become_preferable_category) }

    context "when the category is preferable" do
      it "sets the category to preferable" do
        service.call

        category.reload
        if category != become_preferable_category
          expect(category.preferable?).to be(false)
        end
      end
    end

    context "when the category is preferable and another category is set to preferable" do
      it "sets the other category to not preferable" do
        service.call

        current_preferable_category.reload
        expect(current_preferable_category.preferable?).to be(false)
      end
    end
  end
end
