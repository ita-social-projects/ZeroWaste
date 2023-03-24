require "rails_helper"

RSpec.describe "Sitemaps", type: :request do
  describe "GET /index" do
    it "is successful" do
      get sitemap_path

      expect(sitemap_path).to eq("/en/sitemap")
      expect(response.body).to include("Sitemap")
      expect(response).to render_template(:index)
      expect(response).to be_successful
    end

    context "when locale switching" do
      it "is successful" do
        get sitemap_path(locale: :en)

        expect(root_path).to eq("/en")
        expect(response.body).to include("Sitemap")

        get sitemap_path(locale: :uk)

        expect(sitemap_path).to eq("/uk/sitemap")
        expect(response.body).to include("Мапа сайту")
        expect(response).to render_template(:index)
        expect(response).to be_successful
      end
    end
  end
end
