require "rails_helper"

RSpec.describe String do
  context "with #pluralize" do
    context "with months" do
      let(:months) do
        {
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
          11 => "місяців",
          0 => "місяців"
        }
      end

      it "properly pluralizes all months" do
        months.each do |count, expected|
          expect("місяць".pluralize(count: count, locale: :uk)).to eq(expected)
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
          expect("рік".pluralize(count: count, locale: :uk)).to eq(expected)
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
          expect("dog".pluralize(count: 10)).to eq("dogs")
          expect("cat".pluralize(count: 1)).to eq("cat")
          expect("alias".pluralize(count: 123)).to eq("aliases")
          expect("buffalo".pluralize(count: 1, locale: :en)).to eq("buffalo")
          expect("bus".pluralize(count: 0)).to eq("buses")
        end

        it "pluralizes irregular words properly" do
          expect("person".pluralize(count: 10)).to eq("people")
          expect("man".pluralize(count: 1)).to eq("man")
          expect("child".pluralize(count: 0)).to eq("children")
          expect("zombie".pluralize).to eq("zombies")
          expect("sex".pluralize(count: 666)).to eq("sexes")
        end
      end

      context "with words that cannot be plural" do
        it "does not pluralize uncountable words" do
          expect("equipment".pluralize(count: 10)).to eq("equipment")
          expect("information".pluralize).to eq("information")
          expect("rice".pluralize(count: 0)).to eq("rice")
          expect("money".pluralize(count: 1)).to eq("money")
          expect("fish".pluralize(count: 666)).to eq("fish")
        end
      end
    end
  end
end

RSpec.describe ActiveSupport::Inflector do
  context "with #pluralize" do
    it "pluralizes properly" do
      expect(ActiveSupport::Inflector.pluralize("місяць", 2, :uk)).to eq("місяці")
      expect(ActiveSupport::Inflector.pluralize("рік", 0, :uk)).to eq("років")
      expect(ActiveSupport::Inflector.pluralize("dog")).to eq("dogs")
      expect(ActiveSupport::Inflector.pluralize("money", 15)).to eq("money")
      expect(ActiveSupport::Inflector.pluralize("person", 2)).to eq("people")
    end
  end

  context "with #apply_inflections" do
    let(:uk_rules) do
      [
        ["людина", "людина", [1]],
        ["людина", "людини", [2, 3, 4]],
        ["людина", "людей", [0, 5, 6, 7, 8, 9, 10]],
        ["кіт", "коти"]
      ]
    end

    let(:en_rules) do
      [
        ["dog", "dog", [1]],
        ["dog", "dogs", (2..100).to_a],
        ["dog", "other dogs", (100..110).to_a],
        ["cat", "cats"]
      ]
    end

    it "applies properly plurals with ukrainian rules" do
      expect(
        ActiveSupport::Inflector.apply_inflections("людина", uk_rules, :uk, 1)
      ).to eq("людина")

      expect(
        ActiveSupport::Inflector.apply_inflections("людина", uk_rules, :uk, 3)
      ).to eq("людини")

      expect(
        ActiveSupport::Inflector.apply_inflections("людина", uk_rules, :uk, 9)
      ).to eq("людей")

      expect(
        ActiveSupport::Inflector.apply_inflections("кіт", uk_rules, :uk)
      ).to eq("коти")

      expect(
        ActiveSupport::Inflector.apply_inflections("кіт", uk_rules, :uk, 99)
      ).to eq("коти")
    end

    it "applies properly plurals with english rules" do
      expect(
        ActiveSupport::Inflector.apply_inflections("dog", en_rules, :en, 1)
      ).to eq("dog")

      expect(
        ActiveSupport::Inflector.apply_inflections("dog", en_rules, :en, 99)
      ).to eq("dogs")

      expect(
        ActiveSupport::Inflector.apply_inflections("dog", en_rules, :en, 101)
      ).to eq("other dogs")

      expect(
        ActiveSupport::Inflector.apply_inflections("cat", en_rules, :en)
      ).to eq("cats")

      expect(
        ActiveSupport::Inflector.apply_inflections("cat", en_rules, :en, 99)
      ).to eq("cats")
    end

    it "does not plural empty string" do
      expect(ActiveSupport::Inflector.apply_inflections("", en_rules, :en, 99)).to eq("")
      expect(ActiveSupport::Inflector.apply_inflections("", en_rules, :uk, 99)).to eq("")
      expect(ActiveSupport::Inflector.apply_inflections("", en_rules, :en)).to eq("")
    end

    it "does not plural uncountable words" do
      expect(
        ActiveSupport::Inflector.apply_inflections("equipment", en_rules, :en, 99)
      ).to eq("equipment")

      expect(
        ActiveSupport::Inflector.apply_inflections("money", en_rules, :en)
      ).to eq("money")
    end
  end
end

RSpec.describe ActiveSupport::Inflector::Inflections do
  context "with #plural" do
    let(:uk_plurals) { ActiveSupport::Inflector.inflections(:uk).plurals }

    after do
      ActiveSupport::Inflector.inflections(:uk).plurals.shift
    end

    it "runs properly" do
      ActiveSupport::Inflector.inflections(:uk).plural("машина", "машини", [2, 3, 4])
      expect(uk_plurals.first).to eq(["машина", "машини", [2, 3, 4]])
    end
  end
end
