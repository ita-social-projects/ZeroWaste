require "rails_helper"

RSpec.describe Translatable do
  describe "translations" do
    context "when en_name and uk_name are present" do
      let(:category) { create(:category, en_name: "Books", uk_name: "Книги") }

      it "returns the en_name when locale is set to :en" do
        allow(I18n).to receive(:locale).and_return(:en)

        expect(category.name).to eq("Books")
      end

      it "returns the uk_name when locale is set to :uk" do
        allow(I18n).to receive(:locale).and_return(:uk)

        expect(category.name).to eq("Книги")
      end
    end

    context "when en_name and uk_name are not present, but a default name exists" do
      let(:category) { create(:category) }

      before do
        allow(category).to receive(:uk_name).and_return(nil)
        allow(category).to receive(:en_name).and_return(nil)
        allow(category).to receive(:name).and_return("Default Name")
      end

      it "returns the name when locale is set to :en" do
        allow(I18n).to receive(:locale).and_return(:en)

        expect(category).not_to receive(:en_name)
        expect(category.name).to eq("Default Name")
      end
    end
  end
end
