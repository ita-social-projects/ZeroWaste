# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeatureFlag, type: :model do
  let(:new_flag) { build(:feature_flag) }
  subject(:feature) { described_class.new(new_flag.attributes)}

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe '#feature_exist?' do
    it 'reaturn true if feature is added to table' do
      expect(feature.create.feature_exist?).to be_truthy
    end
  end

  describe '#activate' do
    context 'when feature is not added in table' do
      let(:flag_name){ new_flag.name }
      it { expect(new_flag.activate.reload.enabled).to be_truthy }
    end
    context 'when feature is added in table' do
      it { expect(feature.create.activate.enabled).to be_truthy }
    end
  end

  describe '#deactivate' do
    context 'when feature is not added in table' do
      it { expect(new_flag.deactivate.reload.enabled).to be_falsey }
    end
    context 'when feature is added in table' do
      it { expect(feature.create.deactivate.enabled).to be_falsey }
    end
  end

  describe '#active?' do
    context 'when feature is not added in table' do
      it 'return false' do
        expect(new_flag.active?).to be_falsey
      end
    end

    context 'when feature is added in table' do
      let(:activated_feature) { feature.create.activate }
      it 'return true if feature has active status' do
        expect(activated_feature.active?).to be_truthy
      end
      let(:deactivated_feature) { feature.create.deactivate }
      it 'return false if feature is inactive status' do
        expect(deactivated_feature.active?).to be_falsey
      end
    end
  end
end
