require "rails_helper"

RSpec.describe SiteSetting, type: :model do
  context "is a singleton model" do
    it "should not allow using new method" do
      expect { SiteSetting.new }.to raise_error NoMethodError
    end
    it "should have instance method" do
      expect(SiteSetting.instance).to be_an SiteSetting
    end
  end

  context "validates properly" do
  end
end
