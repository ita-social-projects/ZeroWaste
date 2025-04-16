# frozen_string_literal: true

require "rails_helper"

RSpec.describe Calculators::CalculationService, type: :helper do
  let(:calculator) { instance_double("Calculator", formulas: formulas) }
  let(:formulas) do
    [
      Formula.new(en_label: "Addition", en_unit: "units", uk_label: "Додавання", uk_unit: "одиниці", expression: "x + y", relation: "next"),
      Formula.new(en_label: "Multiplication", en_unit: "units", uk_label: "Множення", uk_unit: "одиниці", expression: "x * y")
    ]
  end
  let(:inputs) { ActionController::Parameters.new({ x: 5, y: 3 }) }

  before do
    allow_any_instance_of(ApplicationHelper).to receive(:current_locale?).with(:en).and_return(locale_en)
  end

  describe "#perform" do
    subject do
      I18n.with_locale(locale_en ? :en : :uk) do
        described_class.new(calculator, inputs).perform
      end
    end

    context "when locale is English" do
      let(:locale_en) { true }

      it "returns results with English labels and units" do
        expect(subject).to eq([
          { label: "Addition", result: 8, unit: "units", relation: "next" },
          { label: "Multiplication", result: 15, unit: "units", relation: nil }
        ])
      end
    end

    context "when locale is Ukrainian" do
      let(:locale_en) { false }

      it "returns results with Ukrainian labels and units" do
        expect(subject).to eq([
          { label: "Додавання", result: 8, unit: "одиниці", relation: "next" },
          { label: "Множення", result: 15, unit: "одиниці", relation: nil }
        ])
      end
    end
  end
end
