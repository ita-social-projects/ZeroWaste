require "rails_helper"

RSpec.describe Categories::PreferableService do
  describe "#call" do
    let!(:become_preferable_category) { create(:category, :medium) }
    let!(:categories) { create_list(:category, 3) }
    let!(:current_preferable_category) { create(:category, :medium) }

    context "when the category is preferable" do
      it "sets the category to preferable" do
        service = described_class.new(become_preferable_category)
        service.call

        categories.each do |category|
          category.reload
          if category != become_preferable_category
            expect(category.preferable?).to be(false)
          end
        end
      end
    end

    context "when the category is preferable and another category is set to preferable" do
      it "sets the other category to not preferable" do
        service = described_class.new(become_preferable_category)
        service.call

        current_preferable_category.reload
        expect(current_preferable_category.preferable?).to be(false)
      end
    end
  end
end
