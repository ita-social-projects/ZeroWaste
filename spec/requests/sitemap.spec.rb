require "rails_helper"

RSpec.describe "Sitemaps", type: :request do
  describe "GET /sitemap_uk" do
    it "returns http success" do
      get sitemap_uk_path

      expect(response).to be_successful
    end
  end

  describe "GET /sitemap_en" do
    it "returns http success" do
      get sitemap_en_path

      expect(response).to be_successful
    end
  end
end
