# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Account::CalculatorsController", type: :request do
  include_context :authorize_admin
  include_context :enable_calculators_constructor

  let!(:calculator) { create(:calculator) }
  let!(:new_attributes) { { calculator: { en_name: "new name" }} }
  let!(:invalid_attributes) { { calculator: { en_name: nil }} }
  let(:user) { create(:user) }
  let(:locale) { "en" }
  let(:new_path) { new_account_calculator_path(locale: locale) }

  describe "DELETE #destroy" do
    it "destroys the calculator and redirects" do
      expect do
        delete account_calculator_path(calculator)
      end.to change(Calculator, :count).by(-1)

      expect(response).to redirect_to(account_calculators_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.calculator_deleted"))
    end
  end

  describe "GET #index" do
    context "when flipper is turned off" do
      include_context :disable_calculators_constructor

      it "raises routing error" do
        expect { get account_calculators_path }.to raise_error(ActionController::RoutingError)
      end
    end

    context "when flipper is turned on" do
      it "loads calculators and renders the index template" do
        get account_calculators_path

        expect(response).to render_template(:index)
        expect(assigns(:calculators)).to include(calculator)
      end
    end
  end

  describe "GET #show" do
    include_context :in_local_environment

    it "renders the calculator template" do
      get account_calculator_path(slug: calculator.slug)

      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    subject { get new_path }

    context "when the user is authorized" do
      it "initializes a new Calculator object with fields and formulas" do
        subject

        expect(response).to have_http_status(:ok)

        calculator = assigns(:calculator)
        expect(calculator).to be_a_new(Calculator)

        expect(calculator.fields.size).to eq(1)
        expect(calculator.formulas.size).to eq(1)

        expect(calculator.fields.first).to be_a_new(Field)
        expect(calculator.formulas.first).to be_a_new(Formula)
      end

      it "renders the new template" do
        subject
        expect(response).to render_template(:new)
      end
    end

    context "when the locale is different" do
      let(:locale) { "uk" }

      it "handles the locale correctly" do
        subject
        expect(I18n.locale).to eq(:uk)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the user is not logged in" do
      before do
        sign_out(:user)
      end

      it "redirects to the login page" do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "is successful" do
        patch account_calculator_path(calculator), params: new_attributes
        calculator.reload

        expect(calculator.en_name).to eq("new name")
        expect(flash[:notice]).to eq(I18n.t("notifications.calculator_updated"))
      end
    end

    context "with invalid parameters" do
      it "is not successful" do
        expect do
          patch account_calculator_path(calculator), params: invalid_attributes
        end.not_to change(calculator, :en_name)

        expect(response).to be_unprocessable
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "GET /account/calculators/:slug" do
    it "renders the calculator's show page correctly" do
      get account_calculator_path(calculator.slug, locale: locale)

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include(calculator.en_name)
      expect(response.body).to include(calculator.slug)
    end
  end

  describe "GET #edit" do
    subject { get edit_account_calculator_path(calculator, locale: locale) }

    context "when the user is authorized" do
      it "assigns the requested calculator to @calculator" do
        subject
        expect(response).to have_http_status(:ok)
        expect(assigns(:calculator)).to eq(calculator)
      end

      it "renders the edit template" do
        subject
        expect(response).to render_template(:edit)
      end
    end

    context "when the user is not logged in" do
      before do
        sign_out(:user)
      end

      it "redirects to the login page" do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when the calculator does not exist" do
      let(:invalid_id) { "non-existing-slug" }

      it "raises an ActiveRecord::RecordNotFound error" do
        expect { get edit_account_calculator_path(invalid_id, locale: locale) }
          .to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET /account/calculators/:slug/duplicate" do
    let!(:field_x) { build(:field, calculator: calculator, var_name: "x").tap { |f| f.save(validate: false) } }
    let!(:field_y) { build(:field, calculator: calculator, var_name: "y").tap { |f| f.save(validate: false) } }
    let!(:formula) { create(:formula, calculator: calculator, expression: "x + y") }

    subject(:perform_request) { get duplicate_account_calculator_path(slug: calculator.slug) }

    it "duplicates calculator" do
      expect { perform_request }.to change(Calculator, :count).by(1)
    end

    it "duplicates fields" do
      expect { perform_request }.to change(Field, :count).by(2)
    end

    it "duplicates formulas" do
      expect { perform_request }.to change(Formula, :count).by(1)
    end

    context "after duplication" do
      before { perform_request }

      let(:copy) { Calculator.find_by(en_name: "#{calculator.en_name} (copy)") }
      let(:cloned_attrs) { [:color, :en_notes, :uk_notes, :logo_placeholder] }
      let(:original_attrs) { calculator.attributes.slice(*cloned_attrs) }
      let(:copy_attrs) { copy.attributes.slice(*cloned_attrs) }

      it "copies all attributes correctly" do
        expect(copy_attrs).to eq(original_attrs)
      end

      it "redirects to the edit duplicated calculator page" do
        expect(response).to redirect_to(edit_account_calculator_path(slug: copy))
      end

      it "copies associated fields" do
        expect(copy.fields.count).to eq(2)
      end

      it "copies associated formulas" do
        expect(copy.formulas.count).to eq(1)
      end

      it "renders new when duplication fails" do
        allow_any_instance_of(Calculator).to receive(:save).and_return(false)
        get duplicate_account_calculator_path(copy.slug)

        expect(response).to be_unprocessable
        expect(response).to render_template(:new)
      end
    end
  end
end
