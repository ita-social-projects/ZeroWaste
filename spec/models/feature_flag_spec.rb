# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeatureFlag, type: :model do
  subject{ build(:feature_flag, enabled: false) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe '#feature_exist?' do
    it 'reaturn true if feature is added to table' do
      expect(subject.create.feature_exist?).to be_truthy
    end
  end

  describe '#activate' do
    context 'when feature is not added in table' do
      it { expect(subject.activate.reload.enabled).to be_truthy }
    end

    context 'when feature is added in table' do
      it { expect(subject.create.activate.enabled).to be_truthy }
    end
  end

  describe '#deactivate' do
    context 'when feature is not added in table' do
      it { expect(subject.deactivate.reload.enabled).to be_falsey }
    end

    context 'when feature is added in table' do
      it { expect(subject.create.deactivate.enabled).to be_falsey }
    end
  end

  describe '#active?' do
    context 'when feature is not added in table' do
      it 'return false' do
        expect(subject.active?).to be_falsey
      end
    end

    context 'when feature is added in table' do
      context 'when feature is activated' do
        subject{ create(:feature_flag, enabled: true) }
        it 'return true' do
          expect(subject.active?).to be_truthy
        end
      end
      
      context 'when feature is deactivated' do
        subject{ create(:feature_flag, enabled: false) }
        it 'return false' do
          expect(subject.active?).to be_falsey
        end
      end
    end
  end
end
