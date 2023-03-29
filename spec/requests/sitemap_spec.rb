require "rails_helper"

RSpec.describe SitemapController, type: :request do
  describe "GET /index" do
    it "is successful" do
      get sitemap_path

      expect(response).to be_successful
      expect(response.body).to include("Sitemap")
      expect(response).to render_template(:index)
    end

    it "renders the XML template" do
      get sitemap_path(format: :xml)

      expect(response).to render_template(:index)
      expect(response.content_type).to eq("application/xml; charset=utf-8")
    end

    it "renders the HTML template" do
      get sitemap_path(format: :html)

      expect(response).to render_template(:index)
      expect(response.content_type).to eq("text/html; charset=utf-8")
    end
  end
end
