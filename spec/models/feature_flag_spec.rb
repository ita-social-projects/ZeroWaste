# frozen_string_literal: true

require 'rails_helper'
require 'pry'

RSpec.describe FeatureFlag, type: :model do
  subject(:created_feature){ described_class.new(name:'created_feature')}
  subject(:added_feature){ created_feature.add_new_feature}

  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:name)
    }
    it {
      is_expected.to validate_uniqueness_of(:name)
    }
  end

  describe '#feature_added?' do
    it 'reaturn true if feature is added to table' do
      expect(added_feature.feature_added?).to be_truthy
    end
  end

  describe '#activate' do
    context 'when feature is not added in table' do
      it {
        expect(created_feature.activate.enabled).to be_truthy
      }
    end
    context 'when feature is added in table' do
      it {
        expect(added_feature.activate.enabled).to be_truthy 
      }
    end
  end

  describe '#deactivate' do
    context 'when feature is not added in table' do
      it {
        expect(created_feature.deactivate.enabled).to be_falsey
      }
    end
    context 'when feature is added in table' do
      it {
        expect(added_feature.deactivate.enabled).to be_falsey 
      }
    end
  end

  describe '#active?' do    
    context 'when feature is not added in table' do
      it 'return false' do
        expect(created_feature.active?).to be_falsey
      end
    end
  
    context 'when feature is added in table' do
      let(:activated_feature) { added_feature.activate}
      it 'return true if feature has active status' do
        expect(activated_feature.active?).to be_truthy
      end
      let(:deactivated_feature) { added_feature.deactivate}
      it 'return false if feature is inactive status' do
        expect(deactivated_feature.active?).to be_falsey
      end
    end
  end

end


