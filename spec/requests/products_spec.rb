require "rails_helper"

RSpec.describe Account::ProductsController, type: :request do
  let!(:product) { create(:product, :diaper) }

  include_context :authorize_admin

  describe "GET :index" do
    it "is successful" do
      get account_products_path

      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include(product.title)
    end
  end

  describe "GET :new" do
    it "is successful" do
      get new_account_product_path

      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe "GET :show" do
    it "is successful" do
      get account_product_path(product)

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include(product.title)
    end
  end

  describe "GET :edit" do
    it "is successful" do
      get edit_account_product_path(product)

      expect(response).to be_successful
      expect(response).to render_template(:edit)

    end
  end

  describe "POST :create" do
    let(:valid_product_attributes) { attributes_for(:product, :diaper) }
    let(:invalid_product_attributes) { attributes_for(:product, title: "") }

    context "creates a product" do
      it "a product with price and category" do
        expect do
          post account_products_path, params: { product: valid_product_attributes }
        end.to change(Product, :count).by(1)

        expect(response).to redirect_to(account_products_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.product_created"))
      end
    end

    context "does not create a product" do
      it "a product without price and category" do
        expect do
          post account_products_path, params: { product: invalid_product_attributes }
        end.not_to change(Product, :count)

        expect(response).to be_unprocessable
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH :update" do
    let(:updated_product_attributes) { attributes_for(:product, title: "huggie") }
    let(:invalid_product_attributes) { attributes_for(:product, title: "") }

    context "with valid params" do
      it "is successful" do
        patch account_product_path(id: product), params: { product: updated_product_attributes }
        product.reload

        expect(product.title).to eq("huggie")

        expect(response).to redirect_to(account_products_path)
        expect(flash[:notice]).to eq(I18n.t("notifications.product_updated"))
      end
    end

    context "with invalid params" do
      it "is failing" do
        expect do
          patch account_product_path(id: product), params: { product: invalid_product_attributes }
        end.not_to change { product.title }.from("diaper")

        expect(response).to be_unprocessable
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE :destroy" do
    it "deletes the product" do
      delete account_product_path(id: product)
      expect { product.to change(Product, :count).by(-1) }

      expect(response).to redirect_to(account_products_path)
      expect(flash[:notice]).to eq(I18n.t("notifications.product_deleted"))
    end
  end
end
