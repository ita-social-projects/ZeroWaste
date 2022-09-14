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
          expect { subject }.to raise_error(ArgumentError)
        }
      end

      context 'when category is string' do
        let(:category) { 'Sd5' }
        it {
          expect { subject }.to raise_error(ArgumentError)
        }
      end

      context 'when category is float' do
        let(:category) { 1.23456789 }
        it {
          expect { subject }.to raise_error(ArgumentError)
        }
      end

      context 'when category is empty' do
        let(:category) { }
        it {
          expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
        }
      end

    end
    context 'check names output' do
      context 'when category "BUDGETARY"' do
        let(:category) { 'BUDGETARY' }
        it {
          expect(subject.category).to eq('BUDGETARY')
        }
      end

      context 'when category "MEDIUM"' do
        let(:category) { 'MEDIUM' }
        it {
          expect(subject.category).to eq('MEDIUM')
        }
      end

      context 'when category "PREMIUM"' do
        let(:category) { 'PREMIUM' }
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
