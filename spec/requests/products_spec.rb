require "rails_helper"

RSpec.describe Account::ProductsController, type: :request do
  let!(:product) { create(:product, title: "Huggies") }

  include_context :authorize_admin

  describe "GET :index" do
    it "is successful" do
      get account_products_path

      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include(product.title)
    end

    it "returns the expected attributes" do
      Product.ransackable_attributes.each do |attribute|
        get account_products_path(q: { s: "#{attribute} asc" })
        expect(response).to be_successful

        get account_products_path(q: { s: "#{attribute} desc" })
        expect(response).to be_successful
      end
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
    let!(:category) { create(:category, :budgetary) }

    it "is successful" do
      get edit_account_product_path(product)

      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end
  end

  describe "POST :create" do
    let(:valid_product_attributes) { attributes_for(:product, title: "Libero") }
    let(:invalid_product_attributes) { attributes_for(:product, :invalid) }

    context "with valid attributes" do
      it "creates a product" do
        expect do
          post account_products_path, params: { product: valid_product_attributes }
        end.to change(Product, :count).by(1)

        expect(response).to redirect_to(account_products_path)
        expect(flash[:notice]).to eq(I18n.t("account.products.created"))
      end
    end

    context "with duplicated attributes" do
      before { create(:product, valid_product_attributes) }

      it "doesn't create a duplicated product" do
        expect do
          post account_products_path, params: { product: valid_product_attributes }
        end.not_to change(Product, :count)

        expect(response).to be_unprocessable
        expect(response).to render_template(:new)
        expect(response.body).to include(I18n.t("activerecord.errors.models.product.attributes.title.taken"))
      end
    end

    context "with invalid attributes" do
      it "does not create a product" do
        expect do
          post account_products_path, params: { product: invalid_product_attributes }
        end.not_to change(Product, :count)

        expect(response).to be_unprocessable
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH :update" do
    let(:price) { create(:price, :budgetary_price) }

    let(:updated_product_attributes) { attributes_for(:product, :huggie) }
    let(:invalid_product_attributes) { attributes_for(:product, :invalid) }

    context "with valid attributes" do
      it "updates the product" do
        expect do
          patch account_product_path(id: price.priceable), params: { product: updated_product_attributes }
          price.priceable.reload
        end.to change(price.priceable, :title).from("diaper").to("huggie")

        expect(response).to redirect_to(account_products_path)
        expect(flash[:notice]).to eq(I18n.t("account.products.updated"))
      end
    end

    context "with invalid attributes" do
      it "does not update product" do
        expect do
          patch account_product_path(id: price.priceable), params: { product: invalid_product_attributes }
        end.not_to change(price.priceable, :title)

        expect(response).to be_unprocessable
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE :destroy" do
    let!(:product) { create(:product, :diaper) }

    it "deletes the product" do
      expect do
        delete account_product_path(id: product)
      end.to change(Product, :count).by(-1)

      expect(response).to redirect_to(account_products_path)
      expect(flash[:notice]).to eq(I18n.t("account.products.deleted"))
    end

    context "when destroy fails" do
      before do
        allow_any_instance_of(Product).to receive(:destroy).and_return(false)
      end

      it "does not delete the product and returns unprocessable entity" do
        expect do
          delete account_product_path(id: product)
        end.not_to change(Product, :count)

        expect(response).to be_unprocessable
      end
    end
  end
end
