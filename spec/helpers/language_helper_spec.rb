# frozen_string_literal: true

require "rails_helper"

RSpec.describe LanguageHelpers::UkrLanguage, type: :helper do
  describe "#correct_word_form" do
    let(:diapers_count) {}

    subject { correct_word_form(diapers_count) }

    context "підгузок" do
      let(:diapers_count) { 421.0 }
      let(:diapers_count) { 421 }

      it { expect(subject).to eql("підгузок") }

      it { expect(subject).to eql("підгузок") }
    end

    context "підгузків" do
      let(:diapers_count) { 34711.15 }
      let(:diapers_count) { 32413 }
      let(:diapers_count) { 32413.45 }
      let(:diapers_count) { 34711 }

      it { expect(subject).to eql("підгузків") }

      it { expect(subject).to eql("підгузків") }

      it { expect(subject).to eql("підгузків") }

      it { expect(subject).to eql("підгузків") }
    end

    context "підгузки" do
      let(:diapers_count) { 4532.10 }
      let(:diapers_count) { 5634 }
      let(:diapers_count) { 5634.23 }
      let(:diapers_count) { 4532 }

      it { expect(subject).to eql("підгузки") }

      it { expect(subject).to eql("підгузки") }

      it { expect(subject).to eql("підгузки") }

      it { expect(subject).to eql("підгузки") }
    end
  end
end
