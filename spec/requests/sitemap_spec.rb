require "rails_helper"

RSpec.describe SitemapController, type: :request do
  describe "GET /index" do
    it "is successful" do
      get sitemap_path

      expect(response).to be_successful
      expect(response.body).to include("Sitemap")
      expect(response).to render_template(:index)
    end
  end
  describe "GET /show" do
    it "renders the sitemap" do
      get sitemap_xml_path(format: :xml)

      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end
end
