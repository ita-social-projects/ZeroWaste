# frozen_string_literal: true

class Account::CalculatorsController < Account::BaseController
  before_action :calculator, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def show
    @product = product_resource
    @prices = product_resource.categories_by_prices
  end

  def new
    @products = products_collection
  end

  def edit
    @products = products_collection
  end

  def create
    @calculator = Calculator.new(calculator_params)

    if @calculator.save
      redirect_to account_calculators_path, notice: t("notifications.calculator_created")
    else
      render action: "new"
    end
  end

  def update
    if updater
      redirect_to edit_account_calculator_path(slug: @calculator), notice: t("notifications.calculator_updated")
    else
      render action: "edit"
    end
  end

  def destroy
    @calculator.destroy!

    redirect_to account_calculators_path, notice: t("notifications.calculator_deleted")
  end

  private

  def calculator
    @calculator = Calculator.friendly.find(params[:slug])
  end

  def calculator_params
    params.require(:calculator).permit(
      :name, :id, :slug, :preferable, :product_id,
      fields_attributes: [
        :id, :selector, :label, :name, :value, :unit, :from, :to, :type, :kind,
        :_destroy
      ]
    )
  end

  def updater
    Calculator.transaction do
      ::Calculators::PreferableService.new(calculator_params).perform!
      @calculator.update(calculator_params)

    end
  end

  def products_collection
    Product.all
  end

  def product_prices(product)
    product.categories_by_prices
  end

  def product_resource
    Product.find(@calculator.product_id)
  end
end
