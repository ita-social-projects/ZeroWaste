# frozen_string_literal: true

require "rails_helper"

RSpec.describe Calculators::CalculationService, type: :helper do
  let(:calculator) { instance_double("Calculator", formulas: formulas) }
  let(:formulas) do
    [
      Formula.new(en_label: "Addition", en_unit: "units", uk_label: "Додавання", uk_unit: "одиниці", expression: "x + y"),
      Formula.new(en_label: "Multiplication", en_unit: "units", uk_label: "Множення", uk_unit: "одиниці", expression: "x * y")
    ]
  end
  let(:inputs) { ActionController::Parameters.new({ x: 5, y: 3 }) }

  before do
    allow_any_instance_of(ApplicationHelper).to receive(:current_locale?).with(:en).and_return(locale_en)
    I18n.locale = locale_en ? :en : :uk
  end

  describe "#perform" do
    subject { described_class.new(calculator, inputs).perform }

    context "when locale is English" do
      let(:locale_en) { true }

      it "returns results with English labels and units" do
        expect(subject).to eq([
          { label: "Addition", result: 8, unit: "units" },
          { label: "Multiplication", result: 15, unit: "units" }
        ])
      end
    end

    context "when locale is Ukrainian" do
      let(:locale_en) { false }

      it "returns results with Ukrainian labels and units" do
        expect(subject).to eq([
          { label: "Додавання", result: 8, unit: "одиниці" },
          { label: "Множення", result: 15, unit: "одиниці" }
        ])
      end
    end
  end
end
