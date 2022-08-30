# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LanguageHelper::UkrLanguage do
  describe '#correct_word_form' do

    let(:diapers_count) { }

    subject { LanguageHelper::UkrLanguage.new.correct_word_form(diapers_count) }

    context 'підгузок' do
      let(:diapers_count) {421.0}
      it {expect(subject).to eql("підгузок")}

      let(:diapers_count) {421}
      it {expect(subject).to eql("підгузок")}

    end

    context 'підгузків' do
      let(:diapers_count) {34711.15}
      it {expect(subject).to eql("підгузків")}

      let(:diapers_count) {34711}
      it {expect(subject).to eql("підгузків")}

      let(:diapers_count) {32413.45}
      it {expect(subject).to eql("підгузків")}

      let(:diapers_count) {32413}
      it {expect(subject).to eql("підгузків")}

    end

    context 'підгузки' do
      let(:diapers_count) {4532.10}
      it {expect(subject).to eql("підгузки")}

      let(:diapers_count) {4532}
      it {expect(subject).to eql("підгузки")}

      let(:diapers_count) {5634.23}
      it {expect(subject).to eql("підгузки")}

      let(:diapers_count) {5634}
      it {expect(subject).to eql("підгузки")}

    end
  end
end
