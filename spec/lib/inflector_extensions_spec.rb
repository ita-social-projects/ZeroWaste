require "rails_helper"

RSpec.describe String do
  context "with #pluralize" do
    context "with months" do
      let(:months) do
        {
          0 => "місяців",
          1 => "місяць",
          2 => "місяці",
          3 => "місяці",
          4 => "місяці",
          5 => "місяців",
          6 => "місяців",
          7 => "місяців",
          8 => "місяців",
          9 => "місяців",
          10 => "місяців",
          11 => "місяців"
        }
      end

      it "properly pluralizes all months" do
        months.each do |count, expected|
          expect("місяць".pluralize(count, :uk)).to eq(expected)
        end
      end
    end

    context "with years" do
      let(:years) do
        {
          0 => "років",
          1 => "рік",
          2 => "роки"
        }
      end

      it "properly pluralizes all years" do
        years.each do |count, expected|
          expect("рік".pluralize(count, :uk)).to eq(expected)
        end
      end
    end

    context "with diapers" do
      let(:diapers) do
        {
          0 => "підгузків",
          1 => "підгузок",
          2 => "підгузки",
          9 => "підгузків",
          11 => "підгузків",
          91 => "підгузок",
          1004 => "підгузки"
        }
      end

      it "properly pluralizes all diapers" do
        diapers.each do |count, expected|
          expect("підгузок".pluralize(count, :uk)).to eq(expected)
        end
      end
    end

    context "with common cases with english locale" do
      context "with words that can be plural" do
        it "pluralizes properly without count parameter" do
          expect("dog".pluralize).to eq("dogs")
          expect("cat".pluralize).to eq("cats")
          expect("octopus".pluralize).to eq("octopi")
          expect("buffalo".pluralize).to eq("buffaloes")
          expect("mouse".pluralize).to eq("mice")
        end

        it "pluralizes properly with count parameter" do
          expect("dog".pluralize(10)).to eq("dogs")
          expect("cat".pluralize(1)).to eq("cat")
          expect("alias".pluralize(123)).to eq("aliases")
          expect("buffalo".pluralize(1, :en)).to eq("buffalo")
          expect("bus".pluralize(0)).to eq("buses")
        end

        it "pluralizes irregular words properly" do
          expect("person".pluralize(10)).to eq("people")
          expect("man".pluralize(1)).to eq("man")
          expect("child".pluralize(0)).to eq("children")
          expect("zombie".pluralize).to eq("zombies")
          expect("sex".pluralize(666)).to eq("sexes")
        end
      end

      context "with words that cannot be plural" do
        it "does not pluralize uncountable words" do
          expect("equipment".pluralize(10)).to eq("equipment")
          expect("information".pluralize).to eq("information")
          expect("rice".pluralize(0)).to eq("rice")
          expect("money".pluralize(1)).to eq("money")
          expect("fish".pluralize(666)).to eq("fish")
        end
      end
    end
  end
end

RSpec.describe ActiveSupport::Inflector do
  context "with #pluralize" do
    it "pluralizes properly" do
      expect(described_class.pluralize("місяць", 2, :uk)).to eq("місяці")
      expect(described_class.pluralize("рік", 0, :uk)).to eq("років")
      expect(described_class.pluralize("dog")).to eq("dogs")
      expect(described_class.pluralize("money", 15)).to eq("money")
      expect(described_class.pluralize("person", 2)).to eq("people")
    end
  end

  context "with #apply_inflections" do
    let(:uk_rules) do
      human_inflections_callback = lambda do |count|
        return "людина" if count == 1
        "людини" if (2..4).cover?(count)
      end

      [
        ["людина", "людей", human_inflections_callback],
        ["кіт", "коти"]
      ]
    end

    let(:en_rules) do
      dog_inflections_callback = lambda do |count|
        return "dog" if count == 1
        "dogs" if (2..100).cover?(count)
      end

      [
        ["dog", "other dogs", dog_inflections_callback],
        ["cat", "cats"]
      ]
    end

    it "applies properly plurals with ukrainian rules" do
      expect(described_class.apply_inflections("людина", uk_rules, :uk, 3)).to eq("людини")
      expect(described_class.apply_inflections("людина", uk_rules, :uk, 1)).to eq("людина")
      expect(described_class.apply_inflections("людина", uk_rules, :uk, 9)).to eq("людей")
      expect(described_class.apply_inflections("кіт", uk_rules, :uk)).to eq("коти")
      expect(described_class.apply_inflections("кіт", uk_rules, :uk, 99)).to eq("коти")
    end

    it "applies properly plurals with english rules" do
      expect(described_class.apply_inflections("dog", en_rules, :en, 1)).to eq("dog")
      expect(described_class.apply_inflections("dog", en_rules, :en, 99)).to eq("dogs")
      expect(described_class.apply_inflections("dog", en_rules, :en, 101)).to eq("other dogs")
      expect(described_class.apply_inflections("cat", en_rules, :en)).to eq("cats")
      expect(described_class.apply_inflections("cat", en_rules, :en, 99)).to eq("cats")
    end

    it "does not plural empty string" do
      expect(described_class.apply_inflections("", en_rules, :en, 99)).to eq("")
      expect(described_class.apply_inflections("", en_rules, :uk, 99)).to eq("")
      expect(described_class.apply_inflections("", en_rules, :en)).to eq("")
    end

    it "does not plural uncountable words" do
      expect(described_class.apply_inflections("equipment", en_rules, :en, 99)).to eq("equipment")
      expect(described_class.apply_inflections("money", en_rules, :en)).to eq("money")
    end
  end
end

RSpec.describe ActiveSupport::Inflector::Inflections do
  context "with #plural" do
    let(:uk_plurals) { ActiveSupport::Inflector.inflections(:uk).plurals }
    let(:fake_callback) { lambda {} }

    after do
      ActiveSupport::Inflector.inflections(:uk).plurals.shift
    end

    it "runs properly" do
      ActiveSupport::Inflector.inflections(:uk).plural("машина", "машини", fake_callback)
      expect(uk_plurals.first).to eq(["машина", "машини", fake_callback])
    end
  end
end
