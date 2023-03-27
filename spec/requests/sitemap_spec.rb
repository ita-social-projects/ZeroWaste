require "rails_helper"

RSpec.describe "Sitemaps", type: :request do
  describe "GET /index" do
    it "is successful" do
      get sitemap_path

      expect(response).to be_successful
      expect(response.body).to include("Sitemap")
      expect(response).to render_template(:index)
    end
  end
end
