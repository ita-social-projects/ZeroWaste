# frozen_string_literal: true

class Account::CalculatorsController < Account::BaseController
  before_action :calculator, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def show
    @prices = product_prices(@calculator.product)
    puts @calculator
  end

  def new
    products_collection
  end

  def edit
    collect_fields_for_form
  end

  def create
    @calculator = Calculator.new(calculator_params)

    if @calculator.save
      Product.find(calculator_params[:product_id]).update(calculator_id: @calculator.id)
      redirect_to account_calculators_path, notice: t("notifications.calculator_created")
    else
      render action: "new"
    end
  end

  def update
    if updater
      redirect_to edit_account_calculator_path(slug: @calculator), notice: t("notifications.calculator_updated")
    else
      collect_fields_for_form

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

  def collect_fields_for_form
    @form_fields      = collect_fields_for_kind("form")
    @parameter_fields = collect_fields_for_kind("parameter")
    @result_fields    = collect_fields_for_kind("result")
  end

  def collect_fields_for_kind(kind)
    @calculator
      .fields
      .select { |field| field.kind == kind }
      .sort_by { |field| field.created_at || Time.zone.now }
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
    @products = Product.where(calculator_id: nil)
  end

  def product_prices(product)
    product.categories_by_prices
  end
end
