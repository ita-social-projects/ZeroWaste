require "rails_helper"

RSpec.describe CalculatorsController, type: :controller do
  describe "GET #show" do
    let(:calculator) do
      create(:calculator,
             en_name: "Test Calculator",
             uk_name: "Тестовий Калькулятор",
             fields_attributes: [
               { en_label: "Field A", uk_label: "Поле A", var_name: "a", kind: "number" },
               { en_label: "Field B", uk_label: "Поле B", var_name: "b", kind: "number" }
             ],
             formulas_attributes: [
               { expression: "a + b", en_label: "Formula 1", uk_label: "Формула 1",
                 en_unit: "unit", uk_unit: "одиниця" },
               { expression: "a + b", en_label: "Formula 2", uk_label: "Формула 2",
                 en_unit: "unit", uk_unit: "одиниця" }
             ])
    end

    let(:expected_result) do
      [
        { id: calculator.formulas.first.id, label: "Formula 1", result: 0,
          relation: nil, unit: "unit", formula_image: "/assets/money_spent.png" },
        { id: calculator.formulas.second.id, label: "Formula 2", result: 0,
          relation: nil, unit: "unit", formula_image: "/assets/money_spent.png" }
      ]
    end

    include_context :enable_calculators_constructor

    before do
      allow(controller).to receive(:resource).and_return(calculator)
    end

    it "assigns the correct calculator to @calculator" do
      get :show, params: { slug: calculator.slug, locale: :en }

      expect(assigns(:calculator)).to eq(calculator)
    end

    it "assigns the correct initial results" do
      get :show, params: { slug: calculator.slug, locale: :en }

      expect(assigns(:results)).to eq(expected_result)
    end

    context "when formulas have images attached" do
      let(:formula_with_image) { calculator.formulas.first }

      let(:expected_result_with_image) do
        [
          { id: calculator.formulas.first.id, label: "Formula 1", result: 0,
          relation: nil, unit: "unit", formula_image: "/rails/active_storage/blobs/formula_image.jpg" },
          { id: calculator.formulas.second.id, label: "Formula 2", result: 0,
          relation: nil, unit: "unit", formula_image: "/assets/money_spent.png" }
        ]
      end

      before do
        allow(formula_with_image.formula_image).to receive(:attached?).and_return(true)
        allow(controller).to receive(:rails_blob_path).and_return("/rails/active_storage/blobs/formula_image.jpg")
      end

      it "assigns the correct formula images" do
        get :show, params: { slug: calculator.slug, locale: :en }

        expect(assigns(:results)).to eq(expected_result_with_image)
      end
    end
  end
end
