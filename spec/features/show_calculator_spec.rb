require "rails_helper"

RSpec.describe CalculatorsController, type: :controller do
  describe "GET #show" do
    let(:calculator) { create(:calculator) }

    before do
      allow(controller).to receive(:resource).and_return(calculator)
    end

    context "when result parameter is present" do
      it "assigns @result with the value from params" do
        get :show, params: { slug: calculator.slug, result: "42", locale: :en }
        expect(assigns(:result)).to eq("42")
      end
    end

    context "when result parameter is not present" do
      it "assigns @result as nil" do
        get :show, params: { slug: calculator.slug, locale: :en }
        expect(assigns(:result)).to be_nil
      end
    end

    it "assigns the correct calculator to @calculator" do
      get :show, params: { slug: calculator.slug, locale: :en }
      expect(assigns(:calculator)).to eq(calculator)
    end
  end
end
