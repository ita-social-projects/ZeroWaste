require "rails_helper"

RSpec.describe SitemapController, type: :request do
  describe "GET /show" do
    it "renders the sitemap" do
      get sitemap_path(format: :xml)

      expect(response.content_type).to eq "application/xml; charset=utf-8"
      expect(response).to render_template(:show)
      expect(response).to be_successful
    end
  end
end
