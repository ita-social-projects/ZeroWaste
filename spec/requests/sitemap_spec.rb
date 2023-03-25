require "rails_helper"

RSpec.describe "Sitemaps", type: :request do
  describe "GET /index" do
    it "is successful" do
      get sitemap_path

      expect(response).to be_successful
      expect(response.body).to include("Sitemap")
      expect(response).to render_template(:index)
    end

    context "when locale switching" do
      it "is successful" do
        get sitemap_path(locale: :en)

        expect(sitemap_path).to eq("/en/sitemap")
        expect(response.body).to include("Sitemap")

        get sitemap_path(locale: :uk)

        expect(response).to be_successful
        expect(sitemap_path).to eq("/uk/sitemap")
        expect(response.body).to include("Мапа сайту")
        expect(response).to render_template(:index)
      end
    end
  end
end
