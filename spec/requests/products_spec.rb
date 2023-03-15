require "rails_helper"

# try database cleaner gem
RSpec.describe Account::ProductsController, type: :request do
  before :all do
    let!(:product) { create(:product, :diaper) }
  end

  let(:valid_product_attributes) { { product: { title: "diaper" }} }
  let(:invalid_product_attributes) { { product: { title: "" }} }
  let(:updated_product_attributes) { { product: { title: "huggie" }} }

  include_context :authorize_admin

  # RSpec.shared_examples 'contains successful response' do
  # it { expect(subject).to respond_with(:ok) }
  # end

  # make a get request
  describe "GET :index" do
    it "is successful" do
      get account_products_path

      expect(response).to be_successful
    end
  end

  describe "GET :new" do
    it "is successful" do
      get new_account_product_path

      expect(response).to be_successful
    end
  end

  describe "GET :show" do
    # to create a product before testing
    it "is successful" do
      get account_product_path(id: product.id)

      expect(response).to be_successful
    end
  end

  describe "GET :edit" do
    it "is successful" do
      get edit_account_product_path(id: product.id)

      expect(response).to be_successful
    end
  end

  # make a post request

  describe "POST :create" do
    context "with valid params" do
      it "is successful" do
        expect do
          post account_products_path, params: valid_product_attributes
        end.to change(Product, :count).by(1)

        expect(response).to redirect_to(account_products_path)
        expect(flash[:notice]).to eq("A product was successfully created.")
      end
    end

    context "with invalid params" do
      it "is failing" do
        expect do
          # binding.pry
          post account_products_path, params: invalid_product_attributes
        end.not_to change(Product, :count)

        expect(response).to be_unprocessable
        expect(response).to render_template(:new)
      end
    end
  end

  # make a patch request
  describe "PATCH :update" do
    context "with valid params" do
      it "is successful" do
        patch account_product_path(id: product), params: updated_product_attributes
        product.reload

        expect(product.title).to eq("huggie")
        expect(response).to redirect_to(account_products_path)
        expect(flash[:notice]).to eq("A product was successfully updated.")
      end
    end

    context "with invalid params" do
      it "is failing" do
        expect do
          patch account_product_path(id: product), params: invalid_product_attributes
        end.not_to change { product.title }.from("diaper")

        expect(response).to be_unprocessable # to have http_status
        expect(response).to render_template(:edit)
      end
    end
  end

  # make a delete request
  describe "DELETE :destroy" do
    it "deletes the product" do
      delete account_product_path(id: product)
      expect { product.to change(Product, :count).by(-1) }

      expect(response).to redirect_to(account_products_path)
      expect(flash[:notice]).to eq("A product was successfully destroyed.")
    end
  end
end
