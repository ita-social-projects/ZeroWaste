# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductPrice, type: :model do
  describe 'validations' do
    context 'price' do
      it {
        is_expected.to validate_presence_of(:price)
      }
    end

    context 'category' do
      it {
        is_expected.to validate_presence_of(:category)
      }
    end
  end
  describe 'category' do
    subject { create(:product_price, category: category) }
    context 'check correct input' do

      context 'when category is minus' do
        let(:category) { -1 }
        it {
            is_expected.not_to be_valid
        }
      end

      context 'when category is string' do
        let(:category) { 'Sd5' }
        it {
          is_expected.not_to be_valid
        }
      end

      context 'when category is float' do
        let(:category) { 1.23456789 }
        it {
            is_expected.not_to be_valid
        }
      end

      context 'when category is empty' do
        let(:category) { }
        it {
            is_expected.not_to be_valid
        }
      end

    end
    context 'check names output' do
      context 'when category 0' do
        let(:category) { 0 }
        it {
          expect(subject.category).to eq('BUDGETARY')
        }
      end

      context 'when category 1' do
        let(:category) { 1 }
        it {
          expect(subject.category).to eq('MEDIUM')
        }
      end

      context 'when category 2' do
        let(:category) { 2 }
        it {
          expect(subject.category).to eq('PREMIUM')
        }
      end
    end
  end
  describe 'correct datatype' do
    subject { create(:product_price) }
    context 'when price is a integer' do
      it {
        expect(subject.price).to be_a(Integer)
      }
    end
  end
end