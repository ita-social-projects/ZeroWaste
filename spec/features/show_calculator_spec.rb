require "rails_helper"

RSpec.describe CalculatorsController, type: :controller do
  describe "GET #show" do
    let(:calculator) { create(:calculator) }

    include_context :show_constructor

    before do
      allow(controller).to receive(:resource).and_return(calculator)
    end

    it "assigns the correct calculator to @calculator" do
      get :show, params: { slug: calculator.slug, locale: :en }
      expect(assigns(:calculator)).to eq(calculator)
    end
  end
end
