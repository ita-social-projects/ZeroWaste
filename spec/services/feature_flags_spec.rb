require "rails_helper"

RSpec.describe UpdateFeatureFlagsService do
  let(:params) { { "feature_1_enabled" => "1", "feature_2_enabled" => "0" } }

  describe "#call" do
    it "updates feature flags based on params" do
      allow(Flipper).to receive(:features).and_return([double(name: "feature_1"), double(name: "feature_2")])

      expect(Flipper).to receive(:enable).with("feature_1")
      expect(Flipper).not_to receive(:disable).with("feature_2")

      UpdateFeatureFlagsService.new(params).call
    end
  end
end
