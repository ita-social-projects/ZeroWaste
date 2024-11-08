require "rails_helper"

RSpec.describe HomeController, type: :request do
  describe "GET :index" do
    it "is successful" do
      get root_path

      expect(root_path).to eq("/en")
      expect(response.body).to include("The calculator tells you how many disposable")
      expect(response).to render_template(:index)
      expect(response).to be_successful
    end

    context "with default locale" do
      it "is successful" do
        get root_path

        expect(root_path).to eq("/en")
        expect(response.body).to include("Welcome to the diaper calculator")
        expect(response).to render_template(:index)
        expect(response).to be_successful
      end
    end

    context "redirect to root_url" do
      it "is successful" do
        get "/"

        expect(response).to redirect_to(root_path)
      end
    end

    context "with locale switching" do
      it "is successful" do
        get root_path(locale: :uk)

        expect(root_path).to eq("/uk")
        expect(response.body).to include("Вас вітає калькулятор підгузків")

        get root_path(locale: :en)

        expect(root_path).to eq("/en")
        expect(response.body).to include("Welcome to the diaper calculator")
        expect(response).to render_template(:index)
        expect(response).to be_successful
      end
    end
  end

  describe "GET :about" do
    it "is successful" do
      get about_path

      expect(response).to be_successful
      expect(response).to render_template(:about)
    end
  end

  context "with locale switching" do
    it "is successful" do
      get about_path(locale: :uk)

      expect(response).to be_successful
      expect(response.body).to include("Про нас")

      get about_path(locale: :en)

      expect(response).to be_successful
      expect(response.body).to include("About Us")
      expect(response).to render_template(:about)
    end
  end
end
