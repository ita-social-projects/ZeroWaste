require "rails_helper"

RSpec.describe Account::UpdateFeatureFlagsService do
  let(:feature1) { Flipper[:my_feature] }
  let(:feature2) { Flipper[:access_admin_menu] }

  describe '#call' do
    it 'enables or disables feature flags based on the parameters passed in' do
      expect(Flipper).to receive(:features).and_return([feature1, feature2])

      params = { "#{feature1.key}_enabled" => "1", "#{feature2.key}_enabled" => "0" }
      service = Account::UpdateFeatureFlagsService.new(params)

      expect(feature1).to receive(:enable)
      expect(feature2).to receive(:disable)

      service.call
    end
  end
end
