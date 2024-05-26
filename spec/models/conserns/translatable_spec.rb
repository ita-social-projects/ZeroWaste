require "rails_helper"

RSpec.describe Translatable do
  describe "translations" do
    context "when en_name and uk_name are exist in model" do
      let(:dummy_translatable) { DummyTranslatable.new }

      it "returns the en_name when locale is set to :en" do
        allow(I18n).to receive(:locale).and_return(:en)

        expect(dummy_translatable.name).to eq("Diapers")
      end

      it "returns the uk_name when locale is set to :uk" do
        allow(I18n).to receive(:locale).and_return(:uk)

        expect(dummy_translatable.name).to eq("Підгузки")
      end
    end

    context "when en_name is not exist and a default locale is uk" do
      let(:dummy_translatable) { DummyTranslatable.new(en_name: nil) }

      it "returns the uk_name when locale is set to :en" do
        allow(I18n).to receive(:locale).and_return(:en)
        allow(I18n).to receive(:default_locale).and_return(:uk)

        expect(dummy_translatable.name).to eq("Підгузки")
      end
    end
  end
end
