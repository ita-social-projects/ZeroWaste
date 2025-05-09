require "rails_helper"

RSpec.describe Api::V2::ApplicationController, type: :request do
  describe "#set_i18n_locale_from_params" do
    let(:locale) { :en }

    it "sets the I18n locale" do
      expect(I18n).to receive(:locale=).at_least(:once)

      post "/#{locale}/api/v2/diaper_calculators"
    end
  end
end
