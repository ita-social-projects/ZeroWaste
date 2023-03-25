require "rails_helper"

RSpec.describe SitemapController, type: :request do
  describe "GET /show" do
    it "renders the sitemap for en" do
      get "/en/sitemap.xml"
      expect(response).to be_successful
    end

    it "renders the sitemap for uk" do
      get "/uk/sitemap.xml"
      expect(response).to be_successful
    end
  end
end
