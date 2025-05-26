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

  describe "localized_column_for" do
    let(:attribute_with_locales) { "name" }
    let(:attribute_without_locale) { "color" }

    context "when current locale column exists" do
      it "returns the column name for :uk locale" do
        I18n.with_locale(:uk) do
          expect(Calculator.localized_column_for(attribute_with_locales)).to eq("uk_name")
        end
      end

      it "returns the column name for :en locale" do
        I18n.with_locale(:en) do
          expect(Calculator.localized_column_for(attribute_with_locales)).to eq("en_name")
        end
      end
    end

    context "when current locale column does not exist, but default locale column exists" do
      it "returns the column name for the default locale" do
        I18n.with_locale(:uk) do
          allow(Calculator).to receive(:column_names).and_return(["en_name", "another_column"])
          expect(Calculator.localized_column_for(attribute_with_locales)).to eq("en_name")
        end
      end
    end

    context "when the locale column does not exist and the default locale column does not exist" do
      it "returns the column name without locale" do
        expect(Calculator.localized_column_for(attribute_without_locale)).to eq("color")
      end
    end
  end
end
