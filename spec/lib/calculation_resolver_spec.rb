# frozen_string_literal: true

require "rails_helper"

RSpec.describe CalculationResolver do
  subject { described_class }

  describe "#result" do
    let(:value) { "P1 + 2" }
    let(:parameters) { { p1: 2 } }
    let(:calculator) { create(:calculator) }
    let(:calculation) do
      create(:calculation, value: value, calculator: calculator)
    end

    subject { CalculationResolver.new.result(parameters, calculation.value) }

    context "when pass valid data" do
      it { is_expected.to eq 4 }
    end

    context "when pass empty hash" do
      let(:parameters) { {} }

      it { is_expected.to be_nil }
    end

    context "when pass upcase letter in hash " do
      let(:parameters) { { P1: 2 } }

      it { is_expected.to eq 4 }
    end

    context "when pass value with `since` formula" do
      let(:from) { Date.new(2020, 0o1, 0o1) }
      let(:to) { Date.new(2021, 0o1, 31) }
      let(:value) { "SINCE(#{from}, #{to}, 'day')" }

      it { is_expected.to eq 396 }
    end

    context "when pass value with `items_per_month` formula" do
      let(:value) { "ITEMS_PER_MONTH(P1, F1, F2)" }
      let(:parameters) { { p1: 5 } }

      before do
        create(:range_field,
               selector: "F1",
               from: 0,
               to: 2,
               value: "30",
               label: "label",
               kind: "form",
               calculator: calculator)
        create(:range_field,
               selector: "F2",
               from: 3,
               to: 5,
               value: "70",
               label: "label",
               kind: "form",
               calculator: calculator)
      end

      it { is_expected.to eq(300) }
    end
  end
end
